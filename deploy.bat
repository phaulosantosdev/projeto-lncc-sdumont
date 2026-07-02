@echo off
REM Script para Deploy no GitHub Pages - Windows
REM Use: deploy.bat seu-usuario seu-email seu-nome

setlocal enabledelayedexpansion

REM Cores para output
cls
echo.
echo ======================================================
echo   SCRIPT DE DEPLOY GITHUB PAGES - LNCC
echo ======================================================
echo.

REM Validar argumentos
if "%1"=="" (
    echo [ERRO] Faltam argumentos!
    echo Uso: deploy.bat seu-usuario seu-email "Seu Nome"
    echo.
    echo Exemplo:
    echo   deploy.bat seu-usuario seu.email@gmail.com "Seu Nome"
    exit /b 1
)

set GITHUB_USER=%1
set GITHUB_EMAIL=%2
set GITHUB_NAME=%3
set REPO_NAME=Projeto-lncc

echo [1/10] Configurando Git...
git config --global user.name "%GITHUB_NAME%"
git config --global user.email "%GITHUB_EMAIL%"
echo ✓ Git configurado

echo.
echo [2/10] Inicializando repositório...
git init
if %errorlevel% neq 0 echo ⚠ Repositório já inicializado
echo ✓ Repositório OK

echo.
echo [3/10] Adicionando remote origin...
git remote add origin https://github.com/%GITHUB_USER%/%REPO_NAME%.git 2>nul
if %errorlevel% neq 0 (
    echo ⚠ Remote já existe, atualizando...
    git remote set-url origin https://github.com/%GITHUB_USER%/%REPO_NAME%.git
)
echo ✓ Remote configurado

echo.
echo [4/10] Instalando dependências npm...
call npm install
if %errorlevel% neq 0 (
    echo [ERRO] Falha ao instalar dependências
    exit /b 1
)
echo ✓ Dependências instaladas

echo.
echo [5/10] Fazendo build do projeto...
call npm run build
if %errorlevel% neq 0 (
    echo [ERRO] Falha ao fazer build
    exit /b 1
)
echo ✓ Build concluído

echo.
echo [6/10] Adicionando arquivos ao git...
git add .
echo ✓ Arquivos adicionados

echo.
echo [7/10] Fazendo commit...
git commit -m "Deploy: Painel de Produções LNCC - %date%"
if %errorlevel% neq 0 echo ⚠ Nada novo para commitar
echo ✓ Commit OK

echo.
echo [8/10] Renomeando branch para main...
git branch -M main
echo ✓ Branch renomeado

echo.
echo [9/10] Fazendo push para GitHub...
git push -u origin main
if %errorlevel% neq 0 (
    echo [ERRO] Falha ao fazer push
    echo Verifique se o repositório existe no GitHub
    exit /b 1
)
echo ✓ Push concluído

echo.
echo [10/10] Finalizando...
echo ✓ Deploy concluído!

echo.
echo ======================================================
echo   PRÓXIMOS PASSOS
echo ======================================================
echo.
echo 1. Acesse: https://github.com/%GITHUB_USER%/%REPO_NAME%/settings/pages
echo 2. Em "Source", selecione: main branch
echo 3. Aguarde alguns minutos
echo 4. Seu site estará em: https://%GITHUB_USER%.github.io/%REPO_NAME%/
echo.
echo ======================================================
echo.

pause
