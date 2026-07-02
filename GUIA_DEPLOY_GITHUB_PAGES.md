# 🚀 GUIA COMPLETO: DEPLOY NO GITHUB PAGES

## 📌 PRÉ-REQUISITOS

- ✅ Git instalado (versão 2.51.0)
- ✅ Conta GitHub criada
- ✅ Node.js instalado
- ✅ Projeto Vite + React pronto

---

## 🎯 PARTE 1: CRIAR REPOSITÓRIO NO GITHUB

### Passo 1.1: Criar repositório no GitHub

1. Acesse [github.com](https://github.com)
2. Clique no ícone **+** no canto superior direito
3. Selecione **New repository**
4. Preencha:
   - **Repository name**: `Projeto-lncc` (ou seu nome preferido)
   - **Description**: "Painel de Produções Intelectuais LNCC"
   - **Public**: ✅ Marque (para que outros vejam)
   - **Initialize with README**: Deixe desmarcado (vamos fazer depois)
5. Clique em **Create repository**

### Passo 1.2: Copiar o URL do repositório

Na página do repositório criado, clique em **Code** (botão verde) e copie a URL:
```
https://github.com/SEU-USUARIO/Projeto-lncc.git
```

---

## 🎯 PARTE 2: CONFIGURAR GIT LOCALMENTE

### Passo 2.1: Configurar Git (primeira vez apenas)

```bash
git config --global user.name "Seu Nome Aqui"
git config --global user.email "seu.email@gmail.com"
```

### Passo 2.2: Inicializar repositório Git no projeto

```bash
# Na pasta do projeto C:\Users\w10\Desktop\Projeto-lncc
cd C:\Users\w10\Desktop\Projeto-lncc

# Inicializar git
git init

# Adicionar origem remota
git remote add origin https://github.com/SEU-USUARIO/Projeto-lncc.git
```

### Passo 2.3: Criar arquivo .gitignore (se não tiver)

```bash
# O projeto já deve ter, mas verifique
echo "node_modules/" >> .gitignore
echo "dist/" >> .gitignore
echo ".env.local" >> .gitignore
echo "__pycache__/" >> .gitignore
echo "*.pyc" >> .gitignore
```

---

## 🎯 PARTE 3: PREPARAR PROJETO PARA DEPLOY

### Passo 3.1: Instalar dependências

```bash
# No diretório do frontend
npm install
```

### Passo 3.2: Fazer build do frontend

```bash
# Gerar pasta dist com arquivos otimizados
npm run build

# Verifique se a pasta dist foi criada
ls dist/
```

### Passo 3.3: Fazer primeiro commit

```bash
# Adicionar todos os arquivos
git add .

# Fazer commit
git commit -m "Initial commit: Painel de Produções LNCC"

# Fazer push para GitHub (branch main)
git branch -M main
git push -u origin main
```

---

## 🎯 PARTE 4: CONFIGURAR GITHUB PAGES

### Opção A: GitHub Pages com Vite (Recomendado)

#### Passo 4A.1: Atualizar vite.config.js

```javascript
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  base: '/Projeto-lncc/',  // Mudar para seu nome do repositório
})
```

#### Passo 4A.2: Fazer novo build e commit

```bash
npm run build
git add .
git commit -m "Configure GitHub Pages base path"
git push
```

#### Passo 4A.3: Ativar GitHub Pages

1. Vá até seu repositório no GitHub
2. Clique em **Settings**
3. Procure por **Pages** no menu esquerdo
4. Em "Source", selecione:
   - Branch: **main**
   - Folder: **/ (root)** OU **/dist** (se tiver pasta dist)
5. Clique em **Save**

### Opção B: GitHub Pages com workflow automático

#### Passo 4B.1: Criar pasta .github/workflows

```bash
mkdir -p .github/workflows
```

#### Passo 4B.2: Criar arquivo deploy.yml

Crie arquivo: `.github/workflows/deploy.yml`

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      
      - name: Install dependencies
        run: npm install
      
      - name: Build
        run: npm run build
      
      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./dist
```

#### Passo 4B.3: Fazer commit do workflow

```bash
git add .github/workflows/deploy.yml
git commit -m "Add GitHub Pages deployment workflow"
git push
```

---

## 🎯 PARTE 5: ACESSAR SEU DEPLOY

Após seguir todos os passos, sua página estará em:

```
https://SEU-USUARIO.github.io/Projeto-lncc/
```

Exemplo (substitua seu usuário):
```
https://seu-usuario.github.io/Projeto-lncc/
```

---

## ⚠️ IMPORTANTE: BACKEND E BANCO DE DADOS

**Problema**: O GitHub Pages só serve arquivos estáticos (HTML, CSS, JS).
Seu backend (FastAPI) e banco de dados (PostgreSQL) precisam estar em outro servidor.

### Solução Recomendada:

**1. Deploy do Frontend**: GitHub Pages (grátis) ✅
**2. Deploy do Backend**: 
   - Heroku (grátis com cartão)
   - Railway.app (grátis)
   - Render.com (grátis)
   - AWS (com free tier)

**3. Banco de Dados**:
   - Heroku PostgreSQL
   - Railway PostgreSQL
   - AWS RDS

---

## 📝 PRÓXIMOS PASSOS PARA BACKEND

Depois de fazer o frontend no GitHub Pages, você precisará:

1. Enviar backend para Heroku/Railway
2. Enviar banco para PostgreSQL cloud
3. Atualizar a URL da API no frontend:

```javascript
// Em src/features/producoes/services/api.js
// Mudar de localhost para sua URL em produção
const api = axios.create({
  baseURL: 'https://seu-backend.herokuapp.com'
});
```

---

## ❓ DÚVIDAS FREQUENTES

### P: Posso deixar apenas o frontend no GitHub Pages?
R: Sim! Mas precisa do backend rodando em outro lugar. O frontend sem backend mostrará erro ao tentar buscar dados.

### P: Quanto custa?
R: GitHub Pages é **totalmente grátis**. Backend e BD precisam de deploy (alguns serviços oferecem free tier).

### P: Como atualizar o site?
R: Apenas faça commit e push. O GitHub Actions fará o deploy automaticamente.

### P: Por que não usar GitHub Pages para tudo?
R: GitHub Pages é estático. Não suporta Node.js ou Python rodando no servidor.

---

## 🎯 RESUMO DOS COMANDOS

```bash
# Configuração inicial
git config --global user.name "Seu Nome"
git config --global user.email "seu.email@gmail.com"

# No projeto
cd C:\Users\w10\Desktop\Projeto-lncc
git init
git remote add origin https://github.com/SEU-USUARIO/Projeto-lncc.git

# Build e push
npm install
npm run build
git add .
git commit -m "Initial commit"
git branch -M main
git push -u origin main

# Updates
git add .
git commit -m "Sua mensagem aqui"
git push
```

---

**Status**: 📝 Guia completo para GitHub Pages
**Data**: 2026-06-27
**Próximo**: Escolher serviço para backend

