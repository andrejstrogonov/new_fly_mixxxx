# Утилита для завершения запущенного exe (Windows)
# Использование: .\.scripts\kill_running_exe.ps1 -name new_fly_mixxxx.exe
param(
  [string]$name = "new_fly_mixxxx.exe"
)

$procs = Get-Process | Where-Object { $_.Name -like "$($name -replace '\.exe$','')" }
if ($procs.Count -eq 0) {
  Write-Output "Process $name not found."
  exit 0
}

foreach ($p in $procs) {
  try {
    Write-Output "Killing process $($p.Id) $($p.ProcessName)"
    Stop-Process -Id $p.Id -Force -ErrorAction Stop
  } catch {
    Write-Error "Failed to kill process $($p.Id): $_"
  }
}
Write-Output "Done."

