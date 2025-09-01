#!/usr/bin/env powershell
# Script de limpieza para el proyecto caso-2
# Ejecutar como: .\cleanup.ps1

Write-Host "🧹 Iniciando limpieza del proyecto caso-2..." -ForegroundColor Yellow

# Detener todos los contenedores
Write-Host "⏹️ Deteniendo contenedores..." -ForegroundColor Yellow
docker compose down

# Limpiar todo Docker
Write-Host "🗑️ Limpiando Docker completamente..." -ForegroundColor Yellow  
docker system prune -a --volumes -f

# Limpiar certificados
Write-Host "🗑️ Limpiando certificados..." -ForegroundColor Yellow
if (Test-Path "certs") {
    Remove-Item -Recurse -Force "certs"
}

Write-Host "✅ Limpieza completada!" -ForegroundColor Green
