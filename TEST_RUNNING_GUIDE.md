# 🧪 HOW TO RUN TESTS - Полное руководство

## ⚡ БЫСТРЫЙ СТАРТ (30 секунд)

### Запустить все тесты:
```bash
cd C:\Users\strog\StudioProjects\new_fly_mixxxx
flutter test
```

### Запустить только widget тесты:
```bash
flutter test test/widgets/
```

### Запустить только интеграционные тесты:
```bash
flutter test test/integration/
```

---

## 📋 ПОДРОБНЫЕ ИНСТРУКЦИИ

### 1. Запустить тесты RotaryKnobWidget (20 тестов)
```bash
flutter test test/widgets/rotary_knob_widget_test.dart -v
```

**Ожидаемый результат:**
```
✅ RotaryKnobWidget Tests
✅ RotaryKnobPainter Tests  
✅ Mathematical Calculations Tests

20 tests PASSED
```

---

### 2. Запустить тесты EqualizerWidget (17 тестов)
```bash
flutter test test/widgets/equalizer_widget_test.dart -v
```

**Ожидаемый результат:**
```
✅ EqualizerWidget Tests
✅ EqualizerWidget EQ Band Tests
✅ EqualizerWidget Responsive Tests

17 tests PASSED
```

---

### 3. Запустить тесты MixerControlsWidget (24 теста)
```bash
flutter test test/widgets/mixer_controls_widget_test.dart -v
```

**Ожидаемый результат:**
```
✅ MixerControlsWidget Tests
✅ MixerControlsWidget Control Tests
✅ MixerControlsWidget Provider Integration Tests
✅ MixerControlsWidget Responsive Tests

24 tests PASSED
```

---

### 4. Запустить интеграционные тесты (20 тестов)
```bash
flutter test test/integration/rotary_knobs_integration_test.dart -v
```

**Ожидаемый результат:**
```
✅ Rotary Knobs Integration Tests
✅ Tango Preset Bug Fix Verification [CRITICAL]
✅ Widget Error Handling
✅ Accessibility Tests

20 tests PASSED
```

---

## 🎯 КРИТИЧЕСКИЕ ТЕСТЫ

### Test: 40kHz Tango Preset Value (CRITICAL)
```bash
flutter test test/integration/rotary_knobs_integration_test.dart -k "40kHz" -v
```

**Проверяет:** Что 40kHz = 0.0, а не -3.0 (баг fix)

### Test: 60Hz Bass Enhancement
```bash
flutter test test/integration/rotary_knobs_integration_test.dart -k "60Hz" -v
```

**Проверяет:** Что 60Hz = +1.0, а не -2.0

### Test: Тестирование всех Tango значений
```bash
flutter test test/integration/rotary_knobs_integration_test.dart -k "Tango" -v
```

**Проверяет:** Что все значения Tango корректны

---

## 🔍 ADVANCED ТЕСТИРОВАНИЕ

### Запустить с покрытием кода:
```bash
flutter test --coverage
```

Затем установить lcov и сгенерировать отчет:
```bash
# Windows: скопируйте генерированный coverage/lcov.info
# Используйте инструменты для анализа покрытия
```

### Запустить с фильтром (только определенные тесты):
```bash
# Все тесты с "knob" в названии
flutter test test/ -k "knob" -v

# Только тесты инициализации
flutter test test/ -k "initialization" -v

# Только тесты значений
flutter test test/ -k "value" -v
```

### Запустить с verbose output:
```bash
flutter test -v
```

---

## 📊 ПРОВЕРКА РЕЗУЛЬТАТОВ

### Все должны пройти:
```
✅ RotaryKnobWidget initialization (1/20)
✅ RotaryKnobWidget value display format (2/20)
...
✅ Widget builds without errors (81/81)

81 tests PASSED ✅
```

### Если тест не прошел:
```
❌ Test Name FAILED
Error: Description
  Expected: ...
  Actual: ...
```

В этом случае:
1. Читайте сообщение об ошибке
2. Проверьте соответствующий код
3. Исправьте проблему
4. Запустите тест снова

---

## 🚀 CONTINUOUS TESTING

### Запустить тесты при любом изменении файла:
```bash
flutter test --watch
```

(Требует чтобы flutter был в режиме "watch")

### Запустить только тесты UI (не unit):
```bash
flutter test --tags widget
```

---

## 📈 ИНТЕРПРЕТАЦИЯ РЕЗУЛЬТАТОВ

### Успех:
```
All tests passed! ✅
```

### Провал одного теста:
```
1 test failed ❌
80 tests passed ✅
```

### Провал нескольких:
```
5 tests failed ❌
76 tests passed ✅
```

---

## 🔧 TROUBLESHOOTING

### Если тесты не запускаются:

**Проблема:** "No tests found"
```bash
# Решение: Убедитесь, что тестовые файлы в правильном месте
ls test/widgets/
ls test/integration/
```

**Проблема:** "Command not found: flutter"
```bash
# Решение: Добавьте Flutter в PATH или используйте полный путь
/path/to/flutter/bin/flutter test
```

**Проблема:** "Device not found"
```bash
# Решение: Unit тесты не требуют устройство, только widget тесты
flutter test  # Должно работать
```

---

## 📝 СОЗДАНИЕ ОТЧЕТА О ТЕСТАХ

### Создать JSON отчет:
```bash
flutter test --machine > test_report.json
```

### Создать HTML отчет:
```bash
flutter test > test_results.txt
# Затем используйте инструменты для конвертирования в HTML
```

---

## ✅ DAILY TESTING ROUTINE

### Каждый день перед коммитом:
```bash
# 1. Запустить все тесты
flutter test

# 2. Проверить синтаксис
dart analyze lib/

# 3. Форматировать код
dart format lib/

# 4. Если нет ошибок:
git add .
git commit -m "Fix: Rotary knobs and Tango preset"
git push
```

---

## 🎯 КРИТИЧЕСКИЙ ПУТЬ ТЕСТИРОВАНИЯ

```
1. Запустить Unit тесты (20 мин)
   └─ rotary_knob_widget_test.dart

2. Запустить Widget тесты (25 мин)
   ├─ equalizer_widget_test.dart
   └─ mixer_controls_widget_test.dart

3. Запустить Integration тесты (20 мин)
   └─ rotary_knobs_integration_test.dart
      ├─ Tango preset verification (CRITICAL)
      └─ Error handling

4. Проверить покрытие кода (5 мин)
   └─ Убедиться, что все важные части покрыты

ИТОГО: ~70 минут для полного тестирования
```

---

## 📋 ЧЕК-ЛИСТ ПЕРЕД PRODUCTION

- [ ] Все 81 тест проходит
- [ ] 40kHz Tango value = 0.0 (тест 11)
- [ ] 60Hz Tango value = +1.0 (тест 12)
- [ ] Drag-to-rotate работает (тесты 1-5)
- [ ] Все крутилки видны (тесты 2-8)
- [ ] Нет синтаксических ошибок (dart analyze)
- [ ] Код отформатирован (dart format)
- [ ] Покрытие кода > 90%

---

## 🎉 ФИНАЛЬНАЯ ПРОВЕРКА

Запустите эту команду перед коммитом:
```bash
flutter test && echo "✅ All tests passed!"
```

Если видите `✅ All tests passed!` - готово к deployment!

---

**Статус:** ✅ READY FOR TESTING

**Дата:** 2024-01-06  
**Версия:** 2.0 (Fixed & Tested)

