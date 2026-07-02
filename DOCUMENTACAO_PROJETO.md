 📚 **Documentação do Projeto - Painel de Produções LNCC**

 1️⃣ Informações Gerais do Projeto

 **Nome do Projeto**
 Painel de Produções Intelectuais LNCC SDumont

 **Status do Projeto**
 🟢 CONCLUÍDO - Pronto para Produção

 **Tipo de Licença**
 📋 Licença Interna LNCC - Uso exclusivo para o Laboratório Nacional de Computação Científica

 2️⃣ Visão Geral do Projeto

 **O que é?**
 O Painel de Produções Intelectuais LNCC SDumont é uma aplicação web moderna desenvolvida para centralizar, organizar e  visualizar   as produções científicas e técnicas do Laboratório Nacional de Computação Científica (LNCC). 

 **O que ele faz?**
 A aplicação permite:
 - Catalogar e organizar produções científicas em 430 registros distribuídos entre 2009 e 2026
 - Classificar produções em 3 categorias principais: Bibliográficas (248), Técnicas/Inovação (69) e Projetos com Aporte Financeiro   (113)
 - Filtrar e buscar produções por tipo, subtipo, ano e outros critérios
 - Visualizar tendências através de gráficos interativos mostrando a evolução das produções ao longo dos anos
 - Acessar informações completas de cada produção com descrições detalhadas

 **Para quê serve?**
 O projeto foi desenvolvido para:
 ✅ Facilitar o acesso e consulta às produções intelectuais do LNCC
 ✅ Fornecer uma visão consolidada do histórico de produções científicas
 ✅ Auxiliar na geração de relatórios e análises sobre produtividade
 ✅ Disponibilizar uma interface intuitiva e responsiva para pesquisadores e gestores
 ✅ Manter um registro centralizado e atualizado de todas as produções

 3️⃣ Principais Funcionalidades

 📊 **Dashboard de Totais**
  - Exibe 4 cards informativos com:
  - Total de Produções: 430 produções em todo o período
  - Produções Bibliográficas: 248 artigos, livros, capítulos e trabalhos em congresso
  - Produções Técnicas/Inovação: 69 teses, dissertações, softwares, patentes e relatórios
  - Projetos com Aporte Financeiro: 113 projetos financiados por agências como CNPQ, CAPES, FINEP, FAPEG, etc.

 📈 **Gráfico de Tendência Acumulativa**
  - Visualiza o crescimento cumulativo de produções por ano
  - Período coberto: 2009 a 2026 (18 anos)
  - Tipo: Gráfico de barras interativo
  - Permite identificar picos, quedas e padrões de produtividade
  - Usa biblioteca Recharts para renderização visual

 🔍 **Sistema Avançado de Filtros**
  - Filtro por Ano: Selecione um ano específico (2009-2026) para visualizar produções daquele período
  - Filtro por Tipo: Escolha entre:
  - Produção Bibliográfica
  - Técnicas/Inovação
  - Projetos com Aporte
  - Todos (padrão)
  - Filtro por Subtipo: 16 subtipos diferentes que mudam dinamicamente conforme o tipo selecionado:
  - Bibliográficas: Artigo em Periódico, Livro, Capítulo de Livro, Trabalho Completo em Congresso, Trabalho Resumido em Congresso
  - Técnicas: Tese de Doutorado, Dissertação de Mestrado, Software/Sistema, Patente, Relatório Técnico
  - Financiamento: CNPQ, CAPES, FAPEG, FINEP, Empresa Privada, Agência Internacional

 📋 **Lista Paginada de Produções**
  - Exibe todas as 430 produções em uma lista organizada
  - Paginação: 10 itens por página com navegação Anterior/Próxima
  - Informações por item:
  - Badge com Tipo de Produção (colorida)
  - Badge com Subtipo específico
  - Descrição completa e destacada em box com borda azul
  - Ano de publicação
  - Linhas separadoras: Cada produção separada visualmente para melhor legibilidade

 ✨ **Interface Responsiva**
  - Layout adaptável para diferentes tamanhos de tela
  - Cards informativos com cores distintivas
  - Badges coloridas por tipo de produção
  - Descrições com quebra automática de linha

 4️⃣ Stack Tecnológico Descritivo

  🎨 **Frontend**

  **Tecnologias Principais**
 - React 19.2.4: Framework JavaScript para construção da interface de usuário
 - Componentes funcionais com Hooks
 - Estado gerenciado com `useState` e `useEffect`
 - Renderização otimizada e eficiente

 - Vite 8.0.4: Ferramenta de build e dev server
 - Hot Module Reload (HMR) para desenvolvimento ágil
 - Build otimizado para produção
 - Configuração de proxy para APIs

 - Recharts 3.8.1: Biblioteca de gráficos React
 - Gráficos responsivos e interativos
 - BarChart para visualização de tendências
 - Tooltips e Legendas automáticas

 - Axios 1.14.0: Cliente HTTP para requisições
 - Interceptadores configurados
 - Suporte a promises
 - Tratamento de erros

 - Bootstrap 5.3.3: Framework CSS (via CDN)
 - Componentes de UI prontos
 - Sistema de grid responsivo
 - Customizações com CSS variables

 **Estrutura Frontend**
 
 Frontend rodando em: http://localhost:5173
 Componentes principais:
 - Producoes.jsx - Página principal com filtros e lista
 - DashboardCards.jsx - Cards com totais
 - ProductionYearChart.jsx - Gráfico de tendências
 - Serviço API - Chamadas HTTP ao backend
 - Hook customizado - Debounce para filtros

 🔧 **Backend**

 **Tecnologias Principais**
 - FastAPI: Framework web Python de alta performance
 - Validação automática de dados com Pydantic
 - Documentação automática (Swagger/OpenAPI)
 - Endpoints RESTful bem estruturados

 - Uvicorn: Servidor ASGI para FastAPI
 - Assíncrono e multiplexado
 - Rápido e confiável
 - Pronto para produção

 - SQLAlchemy: ORM (Object Relational Mapping) para Python
 - Abstração do banco de dados
 - Modelos declarativos
 - Queries otimizadas

 - psycopg2: Driver PostgreSQL para Python
 - Conexão nativa com PostgreSQL
 - Suporte a transações ACID

 **Estrutura Backend**

 Backend rodando em: http://localhost:8000
 Arquivos principais:
 - main.py - Endpoints da API
 - database.py - Configuração de conexão
 - models.py - Modelos SQLAlchemy

 Endpoints disponíveis:
 GET /api/health - Verificar saúde
 GET /api/producoes/totais - Totais por tipo
 GET /api/producoes/pagina - Lista paginada
 GET /api/producoes/por-ano - Dados por ano
 GET /api/producoes/subtipos - Subtipos disponíveis

 🗄️ **Banco de Dados**

 Tecnologia
 - PostgreSQL 15**: Banco de dados relacional open-source
 - Transações ACID
 - Integridade referencial
 - Altamente confiável

 **Estrutura do Banco**

 Banco: producao_intelectual
 Usuário: user_producao
 Porta: 5432

 Tabelas principais:
 1. project_bibliographic_production (248 registros)
   - id, description, year, bibliogragraphic_type_id, public, created_at

 2. project_technical_innovation (69 registros)
   - id, description, year, technical_innovation_type_id, public, created_at

 3. project_funding (113 registros)
   - id, description, year, funding_type_id, public, created_at

 Tabelas de tipos:
 - bibliographic_production_type (5 tipos)
 - technical_innovation_production_type (5 tipos)
 - funding_type (6 tipos)

 🐳 **Docker & Containerização**

  Containers
 - frontend-server**: Container Node.js + React + Vite
 - Porta: 5173-5174
 - Dockerfile customizado
 - Comando: 'npm run dev'

 - backend-server: Container Python + FastAPI + Uvicorn
 - Porta: 8000
 - Dockerfile customizado
 - Comando: uvicorn main:app --host 0.0.0.0 --port 8000 

 - postgres-server: Container PostgreSQL 15
  - Porta: 5432
  - Health check ativo
  - Volume persistente para dados

 Docker Compose
 - Arquivo: docker-compose.yml
 - Rede: lncc-network (bridge)
 - Volumes:
 - postgres_data: Persistência do banco
 - Bind mounts: Código-fonte

 🔐 **Segurança & Autenticação**

  Status Atual
 - ✅ API aberta (sem autenticação)
 - ✅ CORS configurado para localhost:5173
 - ✅ Dados públicos (não sensíveis)
 - ⚠️ Não há autenticação de usuário

  **Recomendações Futuras**
 - Implementar JWT para autenticação
 - Rate limiting nos endpoints
 - HTTPS em produção
 - Validação adicional de entrada

 📦 **Dependências Principais**

 Frontend (package.json)

 axios: 1.14.0 - Cliente HTTP
 react: 19.2.4 - Framework UI
 react-dom: ^19.2.4 - DOM React
 recharts: 3.8.1 - Gráficos

 Backend (requirements.txt)

 FastAPI - Framework web
 Uvicorn - Servidor ASGI
 SQLAlchemy - ORM
 psycopg2-binary - Driver PostgreSQL
 python-dotenv - Variáveis de ambiente

 🚀 **Deployment**

 Status de Deploy
 - ⚠️ Não está em produção
 - 📍 Rodando localmente
 - 🔧 Pronto para deploy em servidor

 Opções de Deploy Recomendadas
 - Heroku: Para prototipagem rápida
 - AWS EC2: Para produção escalonável
 - DigitalOcean: Para servidor dedicado
 - Azure Container Instances: Containers gerenciados
 - Docker Swarm: Para múltiplos containers

 Requisitos para Deploy
 - Docker e Docker Compose
 - Server com mínimo 2GB RAM
 - PostgreSQL 15+
 - Node.js 18+ (para build frontend)
 - Python 3.9+ (para backend)

 5️⃣ Estrutura Simplificada do Projeto

 Projeto-lncc/
 │
 ├── 📄 docker-compose.yml          # Orquestração dos containers
 ├── 📄 Dockerfile                  # Imagem do frontend
 ├── 📄 package.json                # Dependências frontend
 ├── 📄 package-lock.json           # Lock das dependências
 ├── 📄 vite.config.js              # Configuração Vite
 ├── 📄 index.html                  # HTML raiz com Bootstrap CDN
 ├── 📄 .env                        # Variáveis de ambiente
 ├── 📄 .gitignore                  # Configuração Git
 │
 ├── 📁 backend/                    # Backend Python + FastAPI
 │   ├── 📄 main.py                 # Endpoints da API
 │   ├── 📄 database.py             # Configuração PostgreSQL
 │   ├── 📄 models.py               # Modelos SQLAlchemy
 │   ├── 📄 requirements.txt        # Dependências Python
 │   └── 📄 Dockerfile              # Imagem do backend
 │
 ├── 📁 src/                        # Código-fonte React
 │   ├── 📄 main.jsx                # Entry point React
 │   ├── 📄 App.jsx                 # Componente raiz
 │   ├── 📄 index.css               # Estilos globais
 │   │
 │   ├── 📁 features/
 │   │   └── 📁 producoes/
 │   │       ├── 📁 pages/
 │   │       │   └── 📄 Producoes.jsx      # Página principal
 │   │       │
 │   │       ├── 📁 components/
 │   │       │   └── 📄 ProductionYearChart.jsx # Gráfico
 │   │       │
 │   │       ├── 📁 services/
 │   │       │   └── 📄 api.js              # Cliente HTTP
 │   │       │
 │   │       └── 📁 hooks/
 │   │           └── 📄 useDebouncedValue.js # Hook customizado
 │   │
 │   └── 📁 dashboard/
 │       └── 📁 components/
 │           └── 📄 DashboardCards.jsx    # Cards de totais
 │
 └── 📁 init.sql/                   # Scripts de inicialização
    └── 📄 01-init.sql             # Criação de tabelas e dados

 **Explicação das Pastas**

 | Pasta | Descrição |
 |-------|-----------|
 | `backend/` | Código Python com API FastAPI |
 | `src/` | Código React organizado por features |
 | `src/features/` | Funcionalidades principais do app |
 | `src/features/producoes/` | Tudo relacionado à listagem de produções |
 | `src/dashboard/` | Componentes do dashboard |
 | `init.sql/` | Scripts de inicialização do PostgreSQL |

 6️⃣ Como Iniciar o Projeto

 Pré-requisitos
 - ✅ Docker e Docker Compose instalados
 - ✅ Node.js 18+ (se quiser rodar frontend localmente)
 - ✅ Python 3.9+ (se quiser rodar backend localmente)
 - ✅ Git (para clonar o repositório)

 Passo 1: Clonar o Repositório
 bash
 git clone https://github.com/seu-usuario/Projeto-lncc.git
 cd Projeto-lncc

 Passo 2: Configurar Variáveis de Ambiente
 bash
 Verifique o arquivo .env (deve estar na raiz)
 cat .env

 Estrutura esperada:
 DATABASE_URL=postgresql://user_producao:password_producao@db:5432/producao_intelectual

 Passo 3: Construir e Iniciar Containers

 Opção A: Começar do Zero (Recomendado)
 bash
 Parar containers se houver algum rodando
 docker compose down

 Reconstruir imagens e iniciar em background
 docker compose up -d --build

 Verificar status
 docker ps

 Opção B: Apenas Iniciar
 bash
 Se as imagens já foram construídas
 docker compose up -d

 Passo 4: Verificar se Tudo está Funcionando

 bash
 Ver logs do backend
 docker logs backend-server

 Ver logs do frontend
 docker logs frontend-server

 Ver logs do postgres
 docker logs postgres-server

 Testar API
 curl http://localhost:8000/api/health

 Resposta esperada:
 # {"status":"healthy","postgres":"connected","result":1}

  Passo 5: Acessar a Aplicação

 Abra seu navegador e acesse:

 http://localhost:5173

 Passo 6: Explorar as Funcionalidades

 1. Dashboard: Veja os totais de produções
 2. Gráfico: Visualize a tendência 2009-2026
 3. Filtros: Teste os filtros por Ano, Tipo e Subtipo
 4. Lista: Navegue pelas 430 produções

 Comandos Úteis para Gerenciamento

 Parar Containers
 bash
 docker compose down

 Parar e Remover Volumes (CUIDADO: Apaga dados)
 bash
 docker compose down -v

 Ver Logs em Tempo Real
 bash
 docker compose logs -f

 Acessar Terminal do Container
 bash
 Backend
 docker exec -it backend-server bash

 Frontend
 docker exec -it frontend-server sh

 PostgreSQL
 docker exec -it postgres-server psql -U user_producao -d producao_intelectual

 Reconstruir Sem Remover Volumes
 bash
 docker compose up -d --build

 7️⃣ Equipe de Desenvolvimento

 **Desenvolvedores**
 - Nome: Paulo henrique Ferreira
 - Cargo: Desenvolvedor Full Stack
 - Email: phaulohenriqueferreira@gmail.com
 - LinkedIn: https://linkedin.com/in/pauloferreirarh
 - GitHub: https://github.com/phaulosantosdev

 - Nome: Rodrigo Carvalho Santos
 - Cargo: Desenvolvedor Full Stack
 - Email: rodrigo.patolino08@gmail.com
 - LinkedIn: https://linkedin.com/rodrigo-carvalho-santos-7a16901aa/
 - GitHub: https://github.com/Santos0905

 **Contribuidores**
 - Rafael Magalhães: Scrum Master
 - Roberto Pinto Souto: Stakeholder
 - Rômulo Lima: Desenvolvedor FullStack
 - Vivian Medeiros: Product Owner


 📋 **Checklist de Funcionalidades**

 Implementadas ✅
 - ✅ Dashboard com 4 cards informativos
 - ✅ Gráfico de tendência 2009-2026
 - ✅ Sistema de filtros dinâmico
 - ✅ Lista paginada de produções
 - ✅ 430 produções no banco de dados
 - ✅ 16 subtipos categorizados
 - ✅ API REST com 5 endpoints
 - ✅ Frontend responsivo com Bootstrap
 - ✅ Descrições completas destacadas
 - ✅ Interface limpa sem hover

 📄 **Licença** 

 Este projeto é licenciado sob  Licença Interna LNCC - Uso exclusivo para o Laboratório Nacional de Computação Científica.

 📊 **Estatísticas do Projeto**

 | Métrica | Valor |
 |---------|-------|
 | Produções Totais | 430 |
 | Produções Bibliográficas | 248 |
 | Produções Técnicas | 69 |
 | Projetos Financiados | 113 |
 | Subtipos Únicos | 16 |
 | Anos Cobertos | 2009-2026 (18 anos) |
 | Endpoints API | 5 |
 | Componentes React | 6 principais |
 | Containers Docker | 3 |
 | Linhas de Código | 1000+ |

 🎯 **Conclusão**

O Painel de Produções Intelectuais LNCC SDumont** é um projeto completo e funcional que centraliza todas as produções científicas e técnicas do laboratório. Com uma arquitetura moderna, stack atualizado e interface intuitiva, o projeto está pronto para uso em produção.

