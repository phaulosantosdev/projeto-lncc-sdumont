@echo off
REM ============================================================
REM Script de Deploy Personalizado - phaulosantosdev
REM ============================================================
REM Customizado para: Paulo Santos
REM GitHub: https://github.com/phaulosantosdev
REM ============================================================

setlocal enabledelayedexpansion

cls
echo.
echo ======================================================
echo   DEPLOY GITHUB PAGES - phaulosantosdev
echo ======================================================
echo.

REM Dados personalizados
set GITHUB_USER=phaulosantosdev
set REPO_NAME=Projeto-lncc
set DEPLOY_URL=https://%GITHUB_USER%.github.io/%REPO_NAME%/

REM Pedir email e nome se não estiverem definidos
if "%1"=="" (
    echo [IMPORTANTE] Preciso de suas informações
    echo.
    set /p GITHUB_EMAIL="Digite seu email do GitHub: "
    set /p GITHUB_NAME="Digite seu nome completo: "
) else (
    set GITHUB_EMAIL=%1
    set GITHUB_NAME=%2
)

REM Validar entrada
if "!GITHUB_EMAIL!"=="" (
    echo [ERRO] Email é obrigatório!
    exit /b 1
)
if "!GITHUB_NAME!"=="" (
    echo [ERRO] Nome é obrigatório!
    exit /b 1
)

echo.
echo [INFO] Iniciando deploy com:
echo        GitHub: %GITHUB_USER%
echo        Email: %GITHUB_EMAIL%
echo        Nome: %GITHUB_NAME%
echo.
pause

REM ============================================================
REM ETAPA 1: Configurar Git
REM ============================================================
echo [1/10] Configurando Git...
git config --global user.name "%GITHUB_NAME%"
git config --global user.email "%GITHUB_EMAIL%"
if %errorlevel% neq 0 (
    echo [ERRO] Falha ao configurar Git
    exit /b 1
)
echo ✓ Git configurado

REM ============================================================
REM ETAPA 2: Inicializar repositório
REM ============================================================
echo.
echo [2/10] Inicializando repositório...
git init >nul 2>&1
echo ✓ Repositório OK

REM ============================================================
REM ETAPA 3: Adicionar remote
REM ============================================================
echo.
echo [3/10] Configurando conexão com GitHub...
git remote remove origin >nul 2>&1
git remote add origin https://github.com/%GITHUB_USER%/%REPO_NAME%.git
if %errorlevel% neq 0 (
    echo [ERRO] Falha ao conectar com GitHub
    exit /b 1
)
echo ✓ GitHub conectado

REM ============================================================
REM ETAPA 4: Instalar dependências
REM ============================================================
echo.
echo [4/10] Instalando dependências npm...
echo        (Isso pode levar 2-5 minutos)
call npm install --silent
if %errorlevel% neq 0 (
    echo [ERRO] Falha ao instalar dependências
    exit /b 1
)
echo ✓ Dependências instaladas

REM ============================================================
REM ETAPA 5: Fazer build
REM ============================================================
echo.
echo [5/10] Compilando projeto...
call npm run build --silent
if %errorlevel% neq 0 (
    echo [ERRO] Falha ao fazer build
    exit /b 1
)
echo ✓ Build concluído

REM ============================================================
REM ETAPA 6: Adicionar arquivos
REM ============================================================
echo.
echo [6/10] Preparando arquivos...
git add . >nul 2>&1
echo ✓ Arquivos preparados

REM ============================================================
REM ETAPA 7: Fazer commit
REM ============================================================
echo.
echo [7/10] Criando commit...
git commit -m "Deploy: Painel de Produções LNCC - %date%" >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠ Nada novo para commitar
)
echo ✓ Commit OK

REM ============================================================
REM ETAPA 8: Renomear branch
REM ============================================================
echo.
echo [8/10] Configurando branch...
git branch -M main >nul 2>&1
echo ✓ Branch configurado

REM ============================================================
REM ETAPA 9: Fazer push
REM ============================================================
echo.
echo [9/10] Enviando para GitHub...
echo        (Pode pedir autenticação no navegador)
git push -u origin main
if %errorlevel% neq 0 (
    echo [ERRO] Falha ao fazer push
    echo Verifique se:
    echo 1. Repositório existe no GitHub
    echo 2. Você tem permissão
    echo 3. Internet está funcionando
    exit /b 1
)
echo ✓ Push concluído

REM ============================================================
REM ETAPA 10: Finalizando
REM ============================================================
echo.
echo [10/10] Finalizando...
echo ✓ Deploy concluído!

REM ============================================================
REM RESUMO FINAL
REM ============================================================
echo.
echo ======================================================
echo   ✅ DEPLOY REALIZADO COM SUCESSO!
echo ======================================================
echo.
echo Informações do Deploy:
echo   GitHub User: %GITHUB_USER%
echo   Repositório: %REPO_NAME%
echo   Email: %GITHUB_EMAIL%
echo   Nome: %GITHUB_NAME%
echo.
echo ⏳ Seu site estará online em 5-10 minutos
echo.
echo 🌐 Acesse em:
echo    %DEPLOY_URL%
echo.
echo 📋 GitHub Repositório:
echo    https://github.com/%GITHUB_USER%/%REPO_NAME%
echo.
echo ⚙️  Configurar GitHub Pages:
echo    https://github.com/%GITHUB_USER%/%REPO_NAME%/settings/pages
echo.
echo 📚 Documentação:
echo    DOCUMENTACAO_PROJETO.md
echo    DEPLOY_PERSONALIZADO.md
echo.
echo ======================================================
echo.

pause

REM Oferecer opção de abrir GitHub
set /p OPEN="Deseja abrir o repositório no navegador? (s/n): "
if /i "%OPEN%"=="s" (
    start https://github.com/%GITHUB_USER%/%REPO_NAME%
)

echo.
echo Encerrando...
timeout /t 2 >nul
