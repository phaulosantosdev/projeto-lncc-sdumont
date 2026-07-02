# 🚀 DEPLOY PERSONALIZADO - phaulosantosdev

## 👤 Seus Dados

```
Usuário GitHub: phaulosantosdev
Perfil: https://github.com/phaulosantosdev
Email: [Seu email aqui - você preenchará]
```

---

## ⚡ EXECUTE AGORA - 3 PASSOS

### Passo 1: Abra o Command Prompt

**Windows 10/11:**
1. Pressione `Windows + R`
2. Digite: `cmd`
3. Pressione Enter

### Passo 2: Navegue para seu projeto

```cmd
cd C:\Users\w10\Desktop\Projeto-lncc
```

### Passo 3: Execute o script de deploy

```cmd
deploy.bat phaulosantosdev seu.email@gmail.com "Seu Nome Aqui"
```

**Exemplo completo:**
```cmd
deploy.bat phaulosantosdev paulo@email.com "Paulo Santos"
```

---

## 📍 APÓS O DEPLOY

Seu projeto estará em:

```
https://phaulosantosdev.github.io/Projeto-lncc/
```

---

## 🎯 O QUE O SCRIPT VAI FAZER

```
1. ✅ Configurar seu Git com nome e email
2. ✅ Inicializar repositório Git
3. ✅ Conectar com seu repositório GitHub
4. ✅ Instalar dependências (npm install)
5. ✅ Fazer build (npm run build)
6. ✅ Adicionar todos os arquivos
7. ✅ Fazer primeiro commit
8. ✅ Fazer push para GitHub
9. ✅ Ativar GitHub Pages automaticamente
10. ✅ Mostrar URL final
```

---

## 🔑 INFORMAÇÕES NECESSÁRIAS

Você precisa fornecer:

1. **Email do GitHub**: (use o email associado à sua conta)
2. **Seu Nome**: (para aparecer no commit)

**Exemplo:**
```
Email: paulo.santos@gmail.com
Nome: Paulo Santos
```

---

## 🔄 PASSO A PASSO DETALHADO (Se preferir fazer manual)

### 1. Configurar Git

```cmd
cd C:\Users\w10\Desktop\Projeto-lncc

git config --global user.name "Seu Nome"
git config --global user.email "seu.email@gmail.com"
```

### 2. Inicializar repositório

```cmd
git init
git remote add origin https://github.com/phaulosantosdev/Projeto-lncc.git
```

### 3. Instalar e fazer build

```cmd
npm install
npm run build
```

### 4. Fazer push

```cmd
git add .
git commit -m "Deploy: Painel de Produções LNCC"
git branch -M main
git push -u origin main
```

### 5. Ativar GitHub Pages

1. Acesse: https://github.com/phaulosantosdev/Projeto-lncc/settings/pages
2. Em "Source" selecione:
   - Branch: **main**
   - Folder: **/dist**
3. Clique em **Save**
4. Aguarde 5-10 minutos

---

## ✅ VERIFICAR SE FUNCIONOU

Após 10 minutos, acesse:

```
https://phaulosantosdev.github.io/Projeto-lncc/
```

Se ver sua aplicação carregando, é um sucesso! 🎉

---

## 📊 STATUS DO DEPLOY

| Item | Status | URL |
|------|--------|-----|
| **GitHub** | ✅ Pronto | https://github.com/phaulosantosdev/Projeto-lncc |
| **GitHub Pages** | ⏳ Após push | https://phaulosantosdev.github.io/Projeto-lncc/ |
| **Documentação** | ✅ Completa | DOCUMENTACAO_PROJETO.md |

---

## 🆘 PRECISA DE AJUDA?

Consulte:
- `DEPLOY_PASSO_A_PASSO.md` - Guia visual
- `GUIA_DEPLOY_GITHUB_PAGES.md` - Guia técnico
- `RESUMO_DEPLOY.md` - Resumo rápido

---

## 🎯 PRÓXIMAS AÇÕES

### ✅ Agora
- [ ] Execute `deploy.bat` com seus dados
- [ ] Aguarde 10 minutos
- [ ] Acesse sua URL

### 📅 Depois
- [ ] Fazer deploy do backend (Heroku/Railway)
- [ ] Atualizar URL da API no frontend
- [ ] Sistema completo online

---

**Usuário**: phaulosantosdev
**Projeto**: Painel de Produções LNCC
**Status**: Pronto para Deploy! 🚀

