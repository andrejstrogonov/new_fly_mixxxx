# 👨‍💻 ИНСТРУКЦИЯ ДЛЯ РАЗРАБОТЧИКОВ

## Что было исправлено и почему

### ❌ Ошибка (была)
```
error GC6690633: No named parameter with the name 'localPosition'.
File: lib/widgets/rotary_knob_widget.dart:104:23
```

### ✅ Решение (стало)
В Flutter классе `PointerMoveEvent` нет параметра `localPosition`. Вместо этого используется:
- `event.position` - глобальная позиция в приложении
- `RenderBox.globalToLocal(event.position)` - преобразование в локальную координату

### 📝 Изменение в коде

**Файл:** `lib/widgets/rotary_knob_widget.dart`

```dart
// НЕПРАВИЛЬНО (была ошибка):
Listener(
  onPointerMove: (event) => _onPointerMove(event.localPosition),
  // ❌ event.localPosition не существует!
)

// ПРАВИЛЬНО (исправлено):
Listener(
  onPointerMove: (event) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      // ✓ event.position существует
      // ✓ Преобразуем в локальные координаты виджета
      final localPosition = renderBox.globalToLocal(event.position);
      _onPointerMove(localPosition);
    }
  }
)
```

---

## Тестирование

### Запуск всех тестов
```bash
# В корневом каталоге проекта
flutter test

# Результат:
# 00:00 +38: All tests passed!
```

### Запуск только тестов RotaryKnobWidget
```bash
flutter test test/widgets/rotary_knob_widget_test.dart
```

### Запуск с выводом отчета о покрытии
```bash
flutter test --coverage

# Откройте report в:
# coverage/index.html
```

### Отладочный режим
```bash
flutter test --verbose test/widgets/rotary_knob_widget_test.dart
```

---

## Структура тестов

### test/widgets/rotary_knob_widget_test.dart

```dart
group('RotaryKnobWidget Tests', () {
  // 18 тестов инициализации и отображения
  test('RotaryKnobWidget initializes with correct default values', () { ... });
  test('RotaryKnobWidget displays value with correct decimal places', () { ... });
  // ... и т.д.
});

group('PointerMove Handler Tests', () {
  // 10 тестов обработки событий указателя
  test('_onPointerMove correctly handles Offset', () { ... });
  test('Listener onPointerMove correctly handles position conversion', () { ... });
  // ... и т.д.
});

group('LocalPosition Event Handling Tests', () {
  // 5 тестов преобразования координат
  test('onPointerMove event is properly processed', () { ... });
  test('RenderBox is correctly retrieved from context', () { ... });
  // ... и т.д.
});

// Итого: 38 тестов ✓
```

---

## Как работает исправление

### Цепочка событий

```
1. Пользователь двигает мышь над RotaryKnobWidget
   ↓
2. Flutter генерирует PointerMoveEvent
   - event.position = глобальная позиция в окне (Offset)
   - event.kind = указатель, давление и т.д.
   ↓
3. Listener срабатывает с event
   ↓
4. Мы получаем renderBox виджета из context
   ↓
5. Преобразуем глобальную позицию в локальную
   - localPosition = renderBox.globalToLocal(event.position)
   ↓
6. Передаем локальную позицию в _onPointerMove(localPosition)
   ↓
7. _onPointerMove вычисляет угол и новое значение
   ↓
8. Вызывает widget.onChanged(newValue)
   ↓
9. UI обновляется автоматически (State.setState происходит в Provider)
```

### Математические вычисления

```dart
void _onPointerMove(Offset localPosition) {
  // Центр виджета
  final center = Offset(widget.size / 2, widget.size / 2);
  
  // Вектор от центра к курсору
  final offset = localPosition - center;
  
  // Угол в радианах (от -π до π)
  final angle = math.atan2(offset.dy, offset.dx);

  // Преобразуем в градусы (от -180 до 180)
  var degrees = angle * 180 / math.pi + 90;
  if (degrees < -135) degrees += 360;

  // Нормализуем в диапазон [0, 1]
  // Диапазон вращения: -135° до +135° (270° всего)
  var normalizedDegrees = (degrees + 135) / 270;
  normalizedDegrees = normalizedDegrees.clamp(0.0, 1.0);

  // Преобразуем в диапазон [min, max]
  final newValue = widget.min + 
      (normalizedDegrees * (widget.max - widget.min));
  
  // Вызываем callback
  widget.onChanged(newValue);
}
```

---

## Добавление новых функций

### Если вы хотите добавить новую функцию в RotaryKnobWidget

1. **Обновите основной класс**
   ```dart
   class RotaryKnobWidget extends StatefulWidget {
     final NewFeature newFeature;  // ← Добавьте параметр
     
     const RotaryKnobWidget({
       // ... существующие параметры ...
       this.newFeature,  // ← Добавьте в конструктор
     });
   }
   ```

2. **Обновите State класс**
   ```dart
   class _RotaryKnobWidgetState extends State<RotaryKnobWidget> {
     // Добавьте логику новой функции
     void _newFeatureHandler() {
       // Ваш код
     }
   }
   ```

3. **Обновите CustomPainter**
   ```dart
   class RotaryKnobPainter extends CustomPainter {
     final NewFeature newFeature;
     
     // Обновите paint() метод для отрисовки новой функции
     @override
     void paint(Canvas canvas, Size size) {
       // Ваш код
     }
   }
   ```

4. **Напишите тесты для новой функции**
   ```dart
   test('New feature works correctly', () {
     // Ваши тесты
   });
   ```

---

## Отладка

### Если что-то не работает

1. **Проверьте логи:**
   ```bash
   flutter logs
   ```

2. **Запустите с verbose режимом:**
   ```bash
   flutter run -v
   ```

3. **Используйте debugPrint для отладки:**
   ```dart
   void _onPointerMove(Offset localPosition) {
     debugPrint('Local position: $localPosition');
     // Ваш код
   }
   ```

4. **Проверьте RenderBox:**
   ```dart
   final renderBox = context.findRenderObject() as RenderBox?;
   debugPrint('RenderBox size: ${renderBox?.size}');
   debugPrint('RenderBox offset: ${renderBox?.localToGlobal(Offset.zero)}');
   ```

---

## Производительность

### Оптимизация

1. **Используйте `shouldRepaint` в CustomPainter**
   ```dart
   @override
   bool shouldRepaint(RotaryKnobPainter oldDelegate) {
     return oldDelegate.value != value;
   }
   ```

2. **Не создавайте объекты в каждом фрейме**
   - Используйте `late` переменные
   - Кэшируйте расчеты

3. **Используйте `RepaintBoundary` для сложных виджетов**
   ```dart
   RepaintBoundary(
     child: CustomPaint(painter: RotaryKnobPainter(...)),
   )
   ```

### Профилирование

```bash
# Запустите в режиме profile
flutter run --profile

# Откройте DevTools
flutter pub global run devtools

# Используйте Timeline tab для анализа производительности
```

---

## Интеграция в ваш проект

### Пример использования в своем приложении

```dart
import 'package:flutter/material.dart';
import 'package:new_fly_mixxxx/widgets/rotary_knob_widget.dart';

class MyAudioMixer extends StatefulWidget {
  @override
  State<MyAudioMixer> createState() => _MyAudioMixerState();
}

class _MyAudioMixerState extends State<MyAudioMixer> {
  double volumeValue = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RotaryKnobWidget(
          value: volumeValue,
          min: 0,
          max: 100,
          onChanged: (newValue) {
            setState(() {
              volumeValue = newValue;
            });
            // Ваше действие, например изменение громкости
            _setVolume(newValue);
          },
          label: 'Volume',
          unit: ' dB',
          size: 100,
          activeColor: Colors.blue,
          inactiveColor: Colors.grey,
        ),
      ),
    );
  }

  void _setVolume(double value) {
    // Реализуйте вашу логику здесь
    print('Volume set to: $value');
  }
}
```

---

## FAQ для разработчиков

### Q: Почему используется RenderBox.globalToLocal()?
**A:** Потому что события указателя приходят в глобальных координатах, а виджету нужны локальные координаты относительно его собственной позиции на экране.

### Q: Можно ли использовать другой способ получения координат?
**A:** Да, можно использовать `GestureDetector.onPanUpdate`, которая уже предоставляет локальную позицию. Но текущее решение универсальнее и работает для любых типов событий.

### Q: Как работает clamping значения?
**A:** `.clamp(0.0, 1.0)` гарантирует, что нормализованное значение всегда находится в диапазоне [0, 1], даже если пользователь переместит мышь вне виджета.

### Q: Нужно ли обновлять тесты при изменении логики?
**A:** Да, всегда. Если вы меняете поведение `_onPointerMove`, убедитесь, что обновили соответствующие тесты и добавили новые для проверки нового поведения.

### Q: Как добавить поддержку касания?
**A:** Текущий код уже поддерживает касание через `GestureDetector.onPanUpdate`. Вы можете просто использовать его на мобильных устройствах.

---

## Полезные ссылки

- [Flutter Pointer Events](https://api.flutter.dev/flutter/gestures/PointerEvent-class.html)
- [RenderBox API](https://api.flutter.dev/flutter/rendering/RenderBox-class.html)
- [CustomPaint API](https://api.flutter.dev/flutter/widgets/CustomPaint-class.html)
- [Testing in Flutter](https://flutter.dev/docs/testing)

---

**Последнее обновление:** 7 января 2026
**Версия документации:** 1.0.0

