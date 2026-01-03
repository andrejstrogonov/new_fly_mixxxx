# Скрипт завершает процесс .exe по имени проекта
# Использование: Запустите в PowerShell из корня репозитория
# Пример: .\scripts\kill_windows_exe.ps1 -exeName "new_fly_mixxxx"
param(
    [string]$exeName = "new_fly_mixxxx"
)

Write-Host "Ищем процессы с именем: $exeName"
$procs = Get-Process -ErrorAction SilentlyContinue | Where-Object { $_.ProcessName -eq $exeName }
if (-not $procs) {
    Write-Host "Процесс не найден."
    exit 0
}

foreach ($p in $procs) {
    Write-Host "Завершаем PID: $($p.Id) Name: $($p.ProcessName)"
    try {
        Stop-Process -Id $p.Id -Force -ErrorAction Stop
        Write-Host "Завершён PID: $($p.Id)"
    } catch {
        Write-Host "Не удалось завершить PID: $($p.Id) — $_"
    }
}

Write-Host "Готово.""}}]}{
