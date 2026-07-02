from fastapi import FastAPI, Depends
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from sqlalchemy import text
from database import SessionLocal, engine
import models, traceback

models.Base.metadata.create_all(bind=engine)
app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5174", "http://localhost:5173", "http://127.0.0.1:5174", "http://127.0.0.1:5173"],
    allow_credentials=True,
    allow_methods=["GET", "POST", "OPTIONS"],
    allow_headers=["Content-Type", "Authorization"],
)

def get_db():
    db = SessionLocal()
    try: yield db
    finally: db.close()

# Mapeamento exato das tabelas para o ambiente PostgreSQL
TIPO_TABELA = {
    "bibliografica": ("project_bibliographic_production", "Bibliografica", "bibliogragraphic_type_id", "bibliographic_production_type"),
    "tecnica/inovacao": ("project_technical_innovation", "Tecnica/Inovacao", "technical_innovation_type_id", "technical_innovation_production_type"),
    "financiamento": ("project_funding", "Projetos com Aporte", "funding_type_id", "funding_type"),
}

def normalizar_tipo(tipo):
    t = (tipo or "").strip().lower().replace("ç", "c").replace("á", "a").replace("é", "e")
    if t in ["", "todos", "outros", "none", "null"]: return "todos"
    for key in TIPO_TABELA:
        if t == key.replace("ç", "c").replace("á", "a").replace("é", "e") or t.startswith(key.split("/")[0]): return key
    return "todos"

def montar_query_bloco(table, display_type, fk, join_table, where, subtipo_filtro):
    sub_where = f" AND j.name = :subtipo_filtro" if subtipo_filtro else ""
    coalesce_val = "''" if display_type == "Projetos com Aporte" else "'Sem subtipo'"
    
    # Query de dados com descrição completa
    data = f"SELECT p.id, p.description, p.year, '{display_type}' AS tipo, COALESCE(j.name, {coalesce_val}) AS subtipo FROM {table} p LEFT JOIN {join_table} j ON p.{fk} = j.id {where} {sub_where}"
    # Query de contagem
    count = f"SELECT COUNT(*) FROM {table} p LEFT JOIN {join_table} j ON p.{fk} = j.id {where} {sub_where}"
    return data, count

@app.get("/api/producoes/pagina")
def pagina_producoes(db: Session = Depends(get_db), tipo: str | None = None, subtipo: str | None = None, ano: int | None = None, limit: int = 10, offset: int = 0):
    try:
        tipo_norm, subtipo_filtro = normalizar_tipo(tipo), (subtipo if subtipo and subtipo != "Todos" else None)
        
        params = {
            "limit": max(1, min(limit, 100)), 
            "offset": max(0, offset),
            **({"ano_filtro": ano} if isinstance(ano, int) else {}),
            **({"subtipo_filtro": subtipo_filtro} if subtipo_filtro else {})
        }

        where = "WHERE p.public = true" + (" AND p.year = :ano_filtro" if isinstance(ano, int) else "")

        if tipo_norm in TIPO_TABELA:
            data_q, count_q = montar_query_bloco(*TIPO_TABELA[tipo_norm], where, subtipo_filtro)
            data_q += " ORDER BY p.year DESC LIMIT :limit OFFSET :offset"
        else:
            selects, counts = [], []
            for k, v in TIPO_TABELA.items():
                d_q, c_q = montar_query_bloco(*v, where, subtipo_filtro)
                selects.append(d_q)
                counts.append(f"({c_q})")
            # UNION ALL garantindo a paginação correta no modo "Todos"
            data_q = f"({' UNION ALL '.join(selects)}) ORDER BY year DESC LIMIT :limit OFFSET :offset"
            count_q = f"SELECT {' + '.join(counts)}"

        res = db.execute(text(data_q), params).fetchall()
        total = db.execute(text(count_q), params).scalar() or 0
        
        items = []
        for r in res:
            items.append({
                "id": r[0],
                "descricao": r[1],
                "titulo": r[1],
                "ano": r[2],
                "tipo": r[3],
                "subtipo": r[4]
            })
        
        return {"items": items, "total": int(total), "filtro": {"tipo": tipo_norm, "subtipo": subtipo_filtro, "ano": ano}}
    except Exception as e:
        traceback.print_exc()
        print(f"Erro em pagina_producoes: {e}")
        return {"items": [], "total": 0, "filtro": {}}

@app.get("/api/producoes/lista")
def listar_producoes(db: Session = Depends(get_db), tipo: str | None = None, ano: int | None = None):
    try:
        tipo_norm = normalizar_tipo(tipo)
        if tipo_norm not in TIPO_TABELA: return []
        params = {"ano_filtro": ano} if isinstance(ano, int) else {}
        where = "WHERE public = true" + (" AND year = :ano_filtro" if isinstance(ano, int) else "")
        res = db.execute(text(f"SELECT id, description, year FROM {TIPO_TABELA[tipo_norm][0]} {where}"), params).fetchall()
        return [{"id": r[0], "descricao": r[1], "titulo": r[1], "ano": r[2]} for r in res]
    except Exception as e:
        print(f"Erro em listar_producoes: {e}")
        return []

@app.get("/api/producoes/totais")
def totais_producoes(db: Session = Depends(get_db)):
    try:
        # Contar cada tipo de produção
        bibliographic = int(db.execute(text(f"SELECT COUNT(*) FROM {TIPO_TABELA['bibliografica'][0]}")).scalar() or 0)
        technical = int(db.execute(text(f"SELECT COUNT(*) FROM {TIPO_TABELA['tecnica/inovacao'][0]}")).scalar() or 0)
        projects_with_funding = int(db.execute(text(f"SELECT COUNT(*) FROM {TIPO_TABELA['financiamento'][0]}")).scalar() or 0)
        
        total_producoes = bibliographic + technical + projects_with_funding
        
        return {
            "total_producoes": total_producoes,
            "bibliographic": bibliographic,
            "technical": technical,
            "projects_with_funding": projects_with_funding
        }
    except Exception as e:
        print(f"Erro em totais_producoes: {e}")
        traceback.print_exc()
        return {"total_producoes": 0, "bibliographic": 0, "technical": 0, "projects_with_funding": 0}

@app.get("/api/producoes/subtipos")
def obter_subtipos(db: Session = Depends(get_db), tipo: str | None = None):
    try:
        tipo_norm = normalizar_tipo(tipo)
        chaves = TIPO_TABELA.keys() if tipo_norm == "todos" else ([tipo_norm] if tipo_norm in TIPO_TABELA else [])
        subtipos = []
        for k in chaves:
            join_table = TIPO_TABELA[k][3]
            res = db.execute(text(f"SELECT DISTINCT name FROM {join_table} WHERE name IS NOT NULL ORDER BY name")).fetchall()
            subtipos.extend([r[0] for r in res])
        return {"subtipos": sorted(list(set(subtipos)))}
    except Exception as e:
        print(f"Erro em obter_subtipos: {e}")
        traceback.print_exc()
        return {"subtipos": []}

@app.get("/api/producoes/por-ano")
def producoes_por_ano(db: Session = Depends(get_db), tipo: str | None = None, subtipo: str | None = None, ano: int | None = None):
    try:
        tipo_norm = normalizar_tipo(tipo)
        subtipo_filtro = subtipo if subtipo and subtipo != "Todos" else None
        
        params = {}
        if isinstance(ano, int):
            params["ano_filtro"] = ano
        if subtipo_filtro:
            params["subtipo_filtro"] = subtipo_filtro
        
        where = "WHERE p.public = true"
        if isinstance(ano, int):
            where += " AND p.year = :ano_filtro"
        
        if tipo_norm in TIPO_TABELA:
            table, _, fk, join_table = TIPO_TABELA[tipo_norm]
            sub_where = f" AND j.name = :subtipo_filtro" if subtipo_filtro else ""
            query = f"SELECT p.year, COUNT(*) as total FROM {table} p LEFT JOIN {join_table} j ON p.{fk} = j.id {where} {sub_where} GROUP BY p.year ORDER BY p.year ASC"
            res = db.execute(text(query), params).fetchall()
            dados = [{"ano": r[0], "total": r[1]} for r in res]
        else:
            # UNION de todos os tipos
            selects = []
            for k, v in TIPO_TABELA.items():
                table, _, fk, join_table = v
                sub_where = f" AND j.name = :subtipo_filtro" if subtipo_filtro else ""
                selects.append(f"SELECT p.year, COUNT(*) as total FROM {table} p LEFT JOIN {join_table} j ON p.{fk} = j.id {where} {sub_where} GROUP BY p.year")
            
            query = " UNION ALL ".join(selects) + " ORDER BY year ASC"
            raw_results = db.execute(text(query), params).fetchall()
            
            # Agregar por ano
            dados_por_ano = {}
            for row in raw_results:
                y = row[0]
                dados_por_ano[y] = dados_por_ano.get(y, 0) + row[1]
            dados = [{"ano": y, "total": t} for y, t in sorted(dados_por_ano.items())]
        
        return {"dados": dados}
    except Exception as e:
        print(f"Erro em producoes_por_ano: {e}")
        traceback.print_exc()
        return {"dados": []}

@app.get("/api/producoes/resumo-filtro")
def resumo_filtro(db: Session = Depends(get_db), tipo: str | None = None, subtipo: str | None = None, ano: int | None = None):
    """Retorna resumo dos filtros aplicados com contagem e descrição"""
    try:
        tipo_norm = normalizar_tipo(tipo)
        subtipo_filtro = subtipo if subtipo and subtipo != "Todos" else None
        
        params = {}
        if isinstance(ano, int):
            params["ano_filtro"] = ano
        if subtipo_filtro:
            params["subtipo_filtro"] = subtipo_filtro
        
        where = "WHERE p.public = true" + (" AND p.year = :ano_filtro" if isinstance(ano, int) else "")
        
        filtro_desc = []
        if tipo_norm != "todos":
            filtro_desc.append(f"Tipo: {tipo_norm.replace('tecnica/inovacao', 'Técnica/Inovação').replace('bibliografica', 'Bibliográfica').replace('financiamento', 'Financiamento')}")
        
        if subtipo_filtro:
            filtro_desc.append(f"Subtipo: {subtipo_filtro}")
        
        if isinstance(ano, int):
            filtro_desc.append(f"Ano: {ano}")
        
        if tipo_norm in TIPO_TABELA:
            table, _, fk, join_table = TIPO_TABELA[tipo_norm]
            sub_where = f" AND j.name = :subtipo_filtro" if subtipo_filtro else ""
            count_q = f"SELECT COUNT(*) FROM {table} p LEFT JOIN {join_table} j ON p.{fk} = j.id {where} {sub_where}"
            total = int(db.execute(text(count_q), params).scalar() or 0)
        else:
            counts = []
            for k, v in TIPO_TABELA.items():
                table, _, fk, join_table = v
                sub_where = f" AND j.name = :subtipo_filtro" if subtipo_filtro else ""
                counts.append(f"(SELECT COUNT(*) FROM {table} p LEFT JOIN {join_table} j ON p.{fk} = j.id {where} {sub_where})")
            count_q = f"SELECT {' + '.join(counts)}"
            total = int(db.execute(text(count_q), params).scalar() or 0)
        
        return {
            "filtro_ativo": bool(tipo_norm != "todos" or subtipo_filtro or isinstance(ano, int)),
            "descricao_filtro": " | ".join(filtro_desc) if filtro_desc else "Sem filtros",
            "total_resultados": total,
            "tipo": tipo_norm,
            "subtipo": subtipo_filtro,
            "ano": ano
        }
    except Exception as e:
        print(f"Erro em resumo_filtro: {e}")
        traceback.print_exc()
        return {"filtro_ativo": False, "descricao_filtro": "", "total_resultados": 0}

@app.get("/api/health")
def health_check(db: Session = Depends(get_db)):
    try: 
        result = db.execute(text("SELECT 1")).scalar()
        return {"status": "healthy", "postgres": "connected", "result": result}
    except Exception as e: 
        return {"status": "unhealthy", "postgres": "disconnected", "error": str(e)}
