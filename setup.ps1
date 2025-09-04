#!/usr/bin/env powershell
# Script de setup automático para el proyecto caso-2
# Ejecutar como: .\setup.ps1

Write-Host "🔧 Iniciando setup automático del proyecto caso-2..." -ForegroundColor Green

# 1. Limpiar contenedores y volúmenes existentes
Write-Host "📦 Limpiando Docker..." -ForegroundColor Yellow
docker compose down 2>$null
docker system prune -a --volumes -f

# 2. Limpiar directorio de certificados
Write-Host "🗑️ Limpiando directorio de certificados..." -ForegroundColor Yellow
if (Test-Path "certs") { 
    Remove-Item -Recurse -Force "certs" 
}
New-Item -ItemType Directory -Force -Path "certs" > $null

# 3. Construir y ejecutar contenedores en orden
Write-Host "🏗️ Construyendo servidor CA..." -ForegroundColor Yellow
docker compose build ca
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error construyendo CA" -ForegroundColor Red
    exit 1
}

Write-Host "🚀 Iniciando servidor CA..." -ForegroundColor Yellow
docker compose up -d ca
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error iniciando CA" -ForegroundColor Red
    exit 1
}

Write-Host "⏳ Esperando que CA genere certificados..." -ForegroundColor Cyan
Start-Sleep 5

Write-Host "🏗️ Construyendo servidor web..." -ForegroundColor Yellow  
docker compose build web
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error construyendo servidor web" -ForegroundColor Red
    exit 1
}

Write-Host "🚀 Iniciando servidor web..." -ForegroundColor Yellow
docker compose up -d web
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error iniciando servidor web" -ForegroundColor Red
    exit 1
}

Write-Host "⏳ Esperando que servidor web obtenga certificados..." -ForegroundColor Cyan
Start-Sleep 10

Write-Host "🏗️ Construyendo servidor de correo..." -ForegroundColor Yellow
docker compose build mail  
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error construyendo servidor de correo" -ForegroundColor Red
    exit 1
}

Write-Host "🚀 Iniciando servidor de correo..." -ForegroundColor Yellow
docker compose up -d mail
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error iniciando servidor de correo" -ForegroundColor Red
    exit 1
}

Write-Host "⏳ Esperando que servicios estén listos..." -ForegroundColor Cyan
Start-Sleep 10

# 4. Verificar estado
Write-Host "📊 Estado de los contenedores:" -ForegroundColor Green
docker ps

Write-Host "🎉 ¡Setup completado exitosamente!" -ForegroundColor Green
Write-Host "📍 Servicios disponibles:" -ForegroundColor Cyan
Write-Host "   - Servidor HTTPS: https://localhost:8443" -ForegroundColor White
Write-Host "   - Servidor SMTP: localhost:25, 465, 587" -ForegroundColor White  
Write-Host "   - Servidor IMAP: localhost:143, 993" -ForegroundColor White

Write-Host ""
Write-Host "📋 Para ver logs:" -ForegroundColor Cyan
Write-Host "   docker logs ca_server" -ForegroundColor White
Write-Host "   docker logs web_server" -ForegroundColor White
Write-Host "   docker logs mail_server" -ForegroundColor White
