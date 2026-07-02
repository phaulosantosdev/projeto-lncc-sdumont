-- ============================================================================
-- LNCC Projeto de Produção Intelectual
-- Script de Inicialização do Banco de Dados - 2009 a 2026 com 430 produções
-- ============================================================================

-- Criar tipos de produção bibliográfica
CREATE TABLE IF NOT EXISTS bibliographic_production_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Criar tipos de inovação técnica
CREATE TABLE IF NOT EXISTS technical_innovation_production_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Criar tipos de financiamento
CREATE TABLE IF NOT EXISTS funding_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Tabela de produções bibliográficas
CREATE TABLE IF NOT EXISTS project_bibliographic_production (
    id SERIAL PRIMARY KEY,
    description TEXT NOT NULL,
    year INTEGER,
    bibliogragraphic_type_id INTEGER REFERENCES bibliographic_production_type(id),
    public BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de produções técnicas e inovação
CREATE TABLE IF NOT EXISTS project_technical_innovation (
    id SERIAL PRIMARY KEY,
    description TEXT NOT NULL,
    year INTEGER,
    technical_innovation_type_id INTEGER REFERENCES technical_innovation_production_type(id),
    public BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de projetos com aporte/financiamento
CREATE TABLE IF NOT EXISTS project_funding (
    id SERIAL PRIMARY KEY,
    description TEXT NOT NULL,
    year INTEGER,
    funding_type_id INTEGER REFERENCES funding_type(id),
    public BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================================
-- DADOS DE EXEMPLO
-- ============================================================================

-- Inserir tipos de produção bibliográfica
INSERT INTO bibliographic_production_type (name) VALUES
('Artigo em Periódico'),
('Livro'),
('Capítulo de Livro'),
('Trabalho Completo em Congresso'),
('Trabalho Resumido em Congresso')
ON CONFLICT (name) DO NOTHING;

-- Inserir tipos de inovação técnica
INSERT INTO technical_innovation_production_type (name) VALUES
('Tese de Doutorado'),
('Dissertação de Mestrado'),
('Software/Sistema'),
('Patente'),
('Relatório Técnico')
ON CONFLICT (name) DO NOTHING;

-- Inserir tipos de financiamento
INSERT INTO funding_type (name) VALUES
('CNPQ'),
('CAPES'),
('FAPEG'),
('FINEP'),
('Empresa Privada'),
('Agência Internacional')
ON CONFLICT (name) DO NOTHING;

-- ============================================================================
-- INSERÇÃO DE PRODUÇÕES BIBLIOGRÁFICAS (248 registros distribuídos 2009-2026)
-- ============================================================================

-- Artigos em Periódico (100 - distribuído 2009-2026)
INSERT INTO project_bibliographic_production (description, year, bibliogragraphic_type_id, public)
SELECT 
    'Artigo: Análise de Performance em Sistemas Computacionais Distribuídos - ' || i,
    2009 + (i % 18),
    1,
    TRUE
FROM generate_series(1, 100) AS i;

-- Livros (50 - distribuído 2009-2026)
INSERT INTO project_bibliographic_production (description, year, bibliogragraphic_type_id, public)
SELECT 
    'Livro: Tópicos Avançados em Computação Científica - Volume ' || i,
    2009 + (i % 18),
    2,
    TRUE
FROM generate_series(1, 50) AS i;

-- Capítulos de Livro (60 - distribuído 2009-2026)
INSERT INTO project_bibliographic_production (description, year, bibliogragraphic_type_id, public)
SELECT 
    'Capítulo: Métodos Numéricos Aplicados à Física Computacional - Capítulo ' || i,
    2009 + (i % 18),
    3,
    TRUE
FROM generate_series(1, 60) AS i;

-- Trabalhos Completos em Congresso (38 - distribuído 2009-2026)
INSERT INTO project_bibliographic_production (description, year, bibliogragraphic_type_id, public)
SELECT 
    'Trabalho Completo: Otimização de Algoritmos para Processamento em Alta Performance - ' || i,
    2009 + (i % 18),
    4,
    TRUE
FROM generate_series(1, 38) AS i;

-- ============================================================================
-- INSERÇÃO DE PRODUÇÕES TÉCNICAS E INOVAÇÃO (69 registros distribuídos 2009-2026)
-- ============================================================================

-- Teses de Doutorado (20 - distribuído 2009-2026)
INSERT INTO project_technical_innovation (description, year, technical_innovation_type_id, public)
SELECT 
    'Tese: Algoritmos Avançados em Computação Paralela - Tese ' || i,
    2009 + (i % 18),
    1,
    TRUE
FROM generate_series(1, 20) AS i;

-- Dissertações de Mestrado (25 - distribuído 2009-2026)
INSERT INTO project_technical_innovation (description, year, technical_innovation_type_id, public)
SELECT 
    'Dissertação: Análise de Redes Neurais em Sistemas Distribuídos - Dissertação ' || i,
    2009 + (i % 18),
    2,
    TRUE
FROM generate_series(1, 25) AS i;

-- Software/Sistemas (15 - distribuído 2009-2026)
INSERT INTO project_technical_innovation (description, year, technical_innovation_type_id, public)
SELECT 
    'Sistema: Plataforma de Simulação Computacional para Dinâmica de Fluidos - v' || i,
    2009 + (i % 18),
    3,
    TRUE
FROM generate_series(1, 15) AS i;

-- Patentes (5 - distribuído 2009-2026)
INSERT INTO project_technical_innovation (description, year, technical_innovation_type_id, public)
SELECT 
    'Patente: Método Inovador de Processamento de Dados em Tempo Real - BR' || (2024000 + i),
    2009 + (i % 18),
    4,
    TRUE
FROM generate_series(1, 5) AS i;

-- Relatórios Técnicos (4 - distribuído 2009-2026)
INSERT INTO project_technical_innovation (description, year, technical_innovation_type_id, public)
SELECT 
    'Relatório Técnico: Benchmarks de Performance em Clusters de Alto Desempenho - ' || i,
    2009 + (i % 18),
    5,
    TRUE
FROM generate_series(1, 4) AS i;

-- ============================================================================
-- INSERÇÃO DE PROJETOS COM APORTE/FINANCIAMENTO (113 registros distribuídos 2009-2026)
-- ============================================================================

-- Projetos CNPQ (25 - distribuído 2009-2026)
INSERT INTO project_funding (description, year, funding_type_id, public)
SELECT 
    'Projeto CNPQ: Desenvolvimento de Algoritmos para Computação Científica - Projeto ' || i,
    2009 + (i % 18),
    1,
    TRUE
FROM generate_series(1, 25) AS i;

-- Projetos CAPES (25 - distribuído 2009-2026)
INSERT INTO project_funding (description, year, funding_type_id, public)
SELECT 
    'Projeto CAPES: Formação de Recursos Humanos em Modelagem Computacional - Projeto ' || i,
    2009 + (i % 18),
    2,
    TRUE
FROM generate_series(1, 25) AS i;

-- Projetos FAPEG (15 - distribuído 2009-2026)
INSERT INTO project_funding (description, year, funding_type_id, public)
SELECT 
    'Projeto FAPEG: Pesquisa em Computação de Alto Desempenho - Projeto ' || i,
    2009 + (i % 18),
    3,
    TRUE
FROM generate_series(1, 15) AS i;

-- Projetos FINEP (20 - distribuído 2009-2026)
INSERT INTO project_funding (description, year, funding_type_id, public)
SELECT 
    'Projeto FINEP: Inovação Tecnológica em Simulação Numérica - Projeto ' || i,
    2009 + (i % 18),
    4,
    TRUE
FROM generate_series(1, 20) AS i;

-- Projetos Empresa Privada (20 - distribuído 2009-2026)
INSERT INTO project_funding (description, year, funding_type_id, public)
SELECT 
    'Projeto Empresa Privada: Solução em Computação em Nuvem - Projeto ' || i,
    2009 + (i % 18),
    5,
    TRUE
FROM generate_series(1, 20) AS i;

-- Projetos Agência Internacional (8 - distribuído 2009-2026)
INSERT INTO project_funding (description, year, funding_type_id, public)
SELECT 
    'Projeto Internacional: Cooperação em Pesquisa Computacional - Projeto ' || i,
    2009 + (i % 18),
    6,
    TRUE
FROM generate_series(1, 8) AS i;

-- ============================================================================
-- VERIFICAÇÃO DOS TOTAIS
-- ============================================================================

-- Verificar contagem total
SELECT 
    'Produções Bibliográficas' as tipo,
    COUNT(*) as total
FROM project_bibliographic_production
UNION ALL
SELECT 
    'Produções Técnicas e Inovação' as tipo,
    COUNT(*) as total
FROM project_technical_innovation
UNION ALL
SELECT 
    'Projetos com Financiamento' as tipo,
    COUNT(*) as total
FROM project_funding
UNION ALL
SELECT 
    'TOTAL GERAL' as tipo,
    (SELECT COUNT(*) FROM project_bibliographic_production) +
    (SELECT COUNT(*) FROM project_technical_innovation) +
    (SELECT COUNT(*) FROM project_funding) as total;
