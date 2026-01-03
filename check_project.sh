#!/bin/bash
fi
    exit 1
    echo ""
    echo "- Run 'flutter doctor -v' for detailed diagnostics"
    echo "- docs/developer/TROUBLESHOOTING.md"
    echo "- docs/developer/SETUP.md"
    echo "For help, see:"
    echo ""
    echo -e "${RED}✗ Some checks failed. Please review the errors above.${NC}"
else
    exit 0
    echo ""
    echo "2. flutter run -d windows (or android)"
    echo "1. flutter pub get"
    echo "Next steps:"
    echo ""
    echo -e "${GREEN}✓ All checks passed! Project is ready for development.${NC}"
if [ $CHECK_FAILED -eq 0 ]; then

echo ""
echo -e "Failed: ${RED}$CHECK_FAILED${NC}"
echo -e "Passed: ${GREEN}$CHECK_PASSED${NC}"
echo "=========================================="
echo "Project Health Check Summary"
echo "=========================================="
echo ""

fi
    grep -E "^\[.+\]" /tmp/flutter_doctor.log | head -5
    echo -e "${YELLOW}⚠ WARNING${NC}: Flutter doctor found issues:"
else
    ((CHECK_PASSED++))
    echo -e "${GREEN}✓ PASS${NC}: Flutter doctor check"
if [ $? -eq 0 ]; then
flutter doctor -v > /tmp/flutter_doctor.log 2>&1
echo "7. Running Flutter Doctor..."
echo ""

check_result $? "scripts/kill_windows_exe.ps1 exists"
test -f "scripts/kill_windows_exe.ps1"
echo "6. Checking Scripts..."
echo ""

check_result $? ".vscode/settings.json exists"
test -f ".vscode/settings.json"

check_result $? ".vscode/launch.json exists"
test -f ".vscode/launch.json"
echo "5. Checking Configuration Files..."
echo ""

check_result $? "docs/developer/SETUP.md exists"
test -f "docs/developer/SETUP.md"

check_result $? "docs/user directory exists"
test -d "docs/user"

check_result $? "docs/developer directory exists"
test -d "docs/developer"

check_result $? "RUN_APP.md exists"
test -f "RUN_APP.md"

check_result $? "README.md exists"
test -f "README.md"
echo "4. Checking Documentation..."
echo ""

check_result $? "lib/screens directory exists"
test -d "lib/screens"

check_result $? "lib/providers directory exists"
test -d "lib/providers"

check_result $? "lib/widgets directory exists"
test -d "lib/widgets"

check_result $? "lib/main.dart exists"
test -f "lib/main.dart"

check_result $? "pubspec.yaml exists"
test -f "pubspec.yaml"
echo "3. Checking Project Structure..."
echo ""

check_result $? "Dart SDK installed"
dart --version > /dev/null 2>&1
echo "2. Checking Dart Installation..."
echo ""

check_result $? "Flutter SDK installed"
flutter --version > /dev/null 2>&1
echo "1. Checking Flutter Installation..."

}
    fi
        ((CHECK_FAILED++))
        echo -e "${RED}✗ FAIL${NC}: $2"
    else
        ((CHECK_PASSED++))
        echo -e "${GREEN}✓ PASS${NC}: $2"
    if [ $1 -eq 0 ]; then
check_result() {
# Function to print test result

CHECK_FAILED=0
CHECK_PASSED=0

NC='\033[0m' # No Color
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
# Colors for output

echo ""
echo "=========================================="
echo "Fly Mixxx - Project Health Check"
echo "=========================================="

# Проверяет корректность настройки проекта
# Project Health Check Script

