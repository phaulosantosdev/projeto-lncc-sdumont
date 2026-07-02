# 📱 DEPLOY PASSO A PASSO - VISUAL

## ⚡ RESUMO EXECUTIVO

```
Seu projeto local
       ↓
    Git + GitHub
       ↓
 GitHub Actions
       ↓
GitHub Pages (Frontend)
       ↓
https://seu-usuario.github.io/Projeto-lncc/
```

---

## 🎯 PASSO 1: CRIAR REPOSITÓRIO NO GITHUB

### Visual do Processo

```
1. Ir para github.com
2. Clicar em [+] → New repository
3. Preencher:
   - Name: Projeto-lncc
   - Description: Painel de Produções LNCC
   - ✓ Public
4. Create repository
```

### Resultado
```
Você terá uma URL como:
https://github.com/seu-usuario/Projeto-lncc
```

---

## 🎯 PASSO 2: CONFIGURAR GIT NO SEU PC

### Via Command Prompt/PowerShell

```cmd
# Abrir Command Prompt (cmd) ou PowerShell
# Executar:

git config --global user.name "Seu Nome Aqui"
git config --global user.email "seu.email@gmail.com"

# Verificar
git config --global --list
```

---

## 🎯 PASSO 3: PREPARAR SEU PROJETO

### Navegar para pasta do projeto

```cmd
# Pressione Ctrl+L na pasta do projeto no Windows Explorer
# Cole: C:\Users\w10\Desktop\Projeto-lncc

# Ou no PowerShell
cd C:\Users\w10\Desktop\Projeto-lncc
```

### Verificar estrutura

```cmd
# Verificar se tem package.json, docker-compose.yml, etc
dir

# Resultado esperado:
# backend/
# src/
# init.sql/
# package.json
# docker-compose.yml
# vite.config.js
# etc
```

---

## 🎯 PASSO 4: INICIALIZAR GIT

```cmd
# Na pasta do projeto
git init
git remote add origin https://github.com/SEU-USUARIO/Projeto-lncc.git

# Verificar
git remote -v

# Resultado esperado:
# origin  https://github.com/seu-usuario/Projeto-lncc.git (fetch)
# origin  https://github.com/seu-usuario/Projeto-lncc.git (push)
```

---

## 🎯 PASSO 5: INSTALAR DEPENDÊNCIAS

```cmd
# Na pasta do projeto
npm install

# Aguarde... pode levar 2-5 minutos
# Verificar se criou pasta node_modules

dir node_modules
```

---

## 🎯 PASSO 6: FAZER BUILD

```cmd
# Ainda na pasta do projeto
npm run build

# Resultado esperado:
# - Criará pasta 'dist/'
# - Arquivos otimizados para produção
```

---

## 🎯 PASSO 7: FAZER PRIMEIRO COMMIT

```cmd
# Adicionar todos os arquivos
git add .

# Criar commit
git commit -m "Initial commit: Painel de Produções LNCC"

# Renomear branch (se necessário)
git branch -M main

# Enviar para GitHub
git push -u origin main

# Na primeira vez pedirá autenticação GitHub
```

### Se pedir autenticação

Escolha: **Autenticar com seu navegador**
- Vai abrir navegador
- Autorizar aplicação Git
- Voltar para terminal

---

## 🎯 PASSO 8: ATIVAR GITHUB PAGES

### No GitHub (Navegador)

```
1. Ir para: https://github.com/seu-usuario/Projeto-lncc
2. Clicar em "Settings" (engrenagem)
3. Menu esquerdo: "Pages"
4. Em "Source" selecionar:
   - Branch: main
   - Folder: /dist
5. Clicar "Save"
6. Aguarde 5-10 minutos
7. Receberá mensagem: 
   "Your site is live at https://seu-usuario.github.io/Projeto-lncc/"
```

---

## ✅ PRONTO! SEU SITE ESTÁ ONLINE

```
Acesse:
https://seu-usuario.github.io/Projeto-lncc/
```

---

## 🔄 FAZER ATUALIZAÇÕES FUTURAS

Sempre que quiser atualizar o site:

```cmd
# 1. Fazer suas alterações nos arquivos

# 2. Fazer novo build
npm run build

# 3. Fazer commit e push
git add .
git commit -m "Descrição da mudança"
git push

# GitHub Actions fará deploy automaticamente
# Site atualizado em 2-3 minutos
```

---

## ⚠️ LEMBRETE: BACKEND NÃO ESTÁ NO GITHUB PAGES

**Importante**: GitHub Pages só hospeda arquivos estáticos (HTML, CSS, JS).

Seu backend (FastAPI) e banco (PostgreSQL) precisam estar em outro serviço.

### Opções gratuitas para Backend:
- **Heroku** (com cartão)
- **Railway.app** (grátis)
- **Render.com** (grátis)
- **Fly.io** (grátis)

### Quando backend estiver online

Altere em `src/features/producoes/services/api.js`:

```javascript
// Mudar de:
const api = axios.create({
  baseURL: 'http://localhost:8000'
});

// Para:
const api = axios.create({
  baseURL: 'https://seu-backend.herokuapp.com'
});
```

---

## 🆘 TROUBLESHOOTING

### P: Git pede autenticação toda hora
R: Configure SSH key ou use Personal Access Token

### P: GitHub Pages demora para atualizar
R: Aguarde 5-10 minutos. Limpe cache do navegador (Ctrl+Shift+Delete)

### P: Vejo erro 404
R: Verifique se `/dist` foi feito build corretamente com `npm run build`

### P: Aplicação carrega mas sem dados
R: Backend não está online. Configure URL do backend em produção.

---

## 📋 CHECKLIST FINAL

- [ ] Criar repositório no GitHub
- [ ] Clonar ou fazer init git localmente
- [ ] Fazer npm install
- [ ] Fazer npm run build
- [ ] Fazer git add . && git commit && git push
- [ ] Ativar GitHub Pages nas Settings
- [ ] Acessar https://seu-usuario.github.io/Projeto-lncc/
- [ ] Confirmar que página carrega
- [ ] (Futuro) Deploy backend em outro serviço
- [ ] (Futuro) Atualizar API URL para produção

---

**Fim do Guia Passo a Passo**

Qualquer dúvida, releia este documento ou consulte o guia completo em `GUIA_DEPLOY_GITHUB_PAGES.md`
