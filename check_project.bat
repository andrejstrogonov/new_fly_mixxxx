@echo off
REM Project Health Check Script for Windows
REM Проверяет корректность настройки проекта

echo.
echo ==========================================
echo Fly Mixxx - Project Health Check
echo ==========================================
echo.

setlocal enabledelayedexpansion
set CHECK_PASSED=0
set CHECK_FAILED=0

REM Function to check file/directory existence
set CHECKS=0
set FAILURES=0

echo 1. Checking Flutter Installation...
flutter --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [PASS] Flutter SDK installed
    set /a CHECK_PASSED+=1
) else (
    echo [FAIL] Flutter SDK installed
    set /a CHECK_FAILED+=1
)

echo.
echo 2. Checking Dart Installation...
dart --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [PASS] Dart SDK installed
    set /a CHECK_PASSED+=1
) else (
    echo [FAIL] Dart SDK installed
    set /a CHECK_FAILED+=1
)

echo.
echo 3. Checking Project Structure...
if exist "pubspec.yaml" (
    echo [PASS] pubspec.yaml exists
    set /a CHECK_PASSED+=1
) else (
    echo [FAIL] pubspec.yaml not found
    set /a CHECK_FAILED+=1
)

if exist "lib\main.dart" (
    echo [PASS] lib/main.dart exists
    set /a CHECK_PASSED+=1
) else (
    echo [FAIL] lib/main.dart not found
    set /a CHECK_FAILED+=1
)

if exist "lib\widgets" (
    echo [PASS] lib/widgets directory exists
    set /a CHECK_PASSED+=1
) else (
    echo [FAIL] lib/widgets directory not found
    set /a CHECK_FAILED+=1
)

if exist "lib\providers" (
    echo [PASS] lib/providers directory exists
    set /a CHECK_PASSED+=1
) else (
    echo [FAIL] lib/providers directory not found
    set /a CHECK_FAILED+=1
)

if exist "lib\screens" (
    echo [PASS] lib/screens directory exists
    set /a CHECK_PASSED+=1
) else (
    echo [FAIL] lib/screens directory not found
    set /a CHECK_FAILED+=1
)

echo.
echo 4. Checking Documentation...
if exist "README.md" (
    echo [PASS] README.md exists
    set /a CHECK_PASSED+=1
) else (
    echo [FAIL] README.md not found
    set /a CHECK_FAILED+=1
)

if exist "RUN_APP.md" (
    echo [PASS] RUN_APP.md exists
    set /a CHECK_PASSED+=1
) else (
    echo [FAIL] RUN_APP.md not found
    set /a CHECK_FAILED+=1
)

if exist "docs\developer" (
    echo [PASS] docs/developer directory exists
    set /a CHECK_PASSED+=1
) else (
    echo [FAIL] docs/developer directory not found
    set /a CHECK_FAILED+=1
)

if exist "docs\user" (
    echo [PASS] docs/user directory exists
    set /a CHECK_PASSED+=1
) else (
    echo [FAIL] docs/user directory not found
    set /a CHECK_FAILED+=1
)

if exist "docs\developer\SETUP.md" (
    echo [PASS] docs/developer/SETUP.md exists
    set /a CHECK_PASSED+=1
) else (
    echo [FAIL] docs/developer/SETUP.md not found
    set /a CHECK_FAILED+=1
)

echo.
echo 5. Checking Configuration Files...
if exist ".vscode\launch.json" (
    echo [PASS] .vscode/launch.json exists
    set /a CHECK_PASSED+=1
) else (
    echo [FAIL] .vscode/launch.json not found
    set /a CHECK_FAILED+=1
)

if exist ".vscode\settings.json" (
    echo [PASS] .vscode/settings.json exists
    set /a CHECK_PASSED+=1
) else (
    echo [FAIL] .vscode/settings.json not found
    set /a CHECK_FAILED+=1
)

echo.
echo 6. Checking Scripts...
if exist "scripts\kill_windows_exe.ps1" (
    echo [PASS] scripts/kill_windows_exe.ps1 exists
    set /a CHECK_PASSED+=1
) else (
    echo [FAIL] scripts/kill_windows_exe.ps1 not found
    set /a CHECK_FAILED+=1
)

echo.
echo 7. Running Flutter Doctor...
flutter doctor -v > nul 2>&1
if %errorlevel% equ 0 (
    echo [PASS] Flutter doctor check
    set /a CHECK_PASSED+=1
) else (
    echo [WARNING] Flutter doctor found issues - run 'flutter doctor -v' for details
)

echo.
echo ==========================================
echo Project Health Check Summary
echo ==========================================
echo Passed: %CHECK_PASSED%
echo Failed: %CHECK_FAILED%
echo.

if %CHECK_FAILED% equ 0 (
    echo Success! All checks passed. Project is ready for development.
    echo.
    echo Next steps:
    echo 1. flutter pub get
    echo 2. flutter run -d windows (or android)
    echo.
    exit /b 0
) else (
    echo Error! Some checks failed. Please review the errors above.
    echo.
    echo For help, see:
    echo - docs\developer\SETUP.md
    echo - docs\developer\TROUBLESHOOTING.md
    echo - Run 'flutter doctor -v' for detailed diagnostics
    echo.
    exit /b 1
)

