import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Rotary knob widget for controlling values (like in professional DJ software Mixxx)
class RotaryKnobWidget extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final String label;
  final String? unit;
  final double size;
  final bool showValue;
  final Color activeColor;
  final Color inactiveColor;

  const RotaryKnobWidget({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.label,
    this.unit,
    this.size = 80,
    this.showValue = true,
    this.activeColor = Colors.deepPurple,
    this.inactiveColor = Colors.grey,
  });

  @override
  State<RotaryKnobWidget> createState() => _RotaryKnobWidgetState();
}

class _RotaryKnobWidgetState extends State<RotaryKnobWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(RotaryKnobWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _onPointerMove(Offset localPosition) {
    // Вычисляем угол от центра к курсору
    final center = Offset(widget.size / 2, widget.size / 2);
    final offset = localPosition - center;
    final angle = math.atan2(offset.dy, offset.dx);

    // Преобразуем угол в значение (-135° to +135°)
    var degrees = angle * 180 / math.pi + 90;
    if (degrees < -135) degrees += 360;

    var normalizedDegrees = (degrees + 135) / 270;
    normalizedDegrees = normalizedDegrees.clamp(0.0, 1.0);

    final newValue = widget.min + (normalizedDegrees * (widget.max - widget.min));
    widget.onChanged(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Крутилка
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: GestureDetector(
            onPanUpdate: (details) {
              // Конвертируем глобальную позицию в локальную координату виджета
              final renderBox = context.findRenderObject() as RenderBox?;
              if (renderBox != null) {
                final localPosition = renderBox.globalToLocal(details.globalPosition);
                _onPointerMove(localPosition);
              }
            },
            child: Listener(
              onPointerMove: (PointerMoveEvent event) {
                final renderBox = context.findRenderObject() as RenderBox?;
                if (renderBox != null) {
                  final localPosition = renderBox.globalToLocal(event.position);
                  _onPointerMove(localPosition);
                }
              },
              child: CustomPaint(
                painter: RotaryKnobPainter(
                  value: widget.value,
                  min: widget.min,
                  max: widget.max,
                  activeColor: widget.activeColor,
                  inactiveColor: widget.inactiveColor,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Метка
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        // Значение
        if (widget.showValue)
          Text(
            '${widget.value.toStringAsFixed(1)}${widget.unit ?? ''}',
            style: TextStyle(
              fontSize: 10,
              color: widget.activeColor,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}

/// Custom painter для отрисовки крутилки
class RotaryKnobPainter extends CustomPainter {
  final double value;
  final double min;
  final double max;
  final Color activeColor;
  final Color inactiveColor;

  RotaryKnobPainter({
    required this.value,
    required this.min,
    required this.max,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 10) / 2;

    // Фоновый круг
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = const Color(0xFF1a1a1a)
        ..style = PaintingStyle.fill,
    );

    // Внешний кольцо
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = inactiveColor.withOpacity(0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Вычисляем угол (от -135° до +135°)
    final normalizedValue = (value - min) / (max - min);
    final angle = -135 + (normalizedValue * 270); // 270 градусов диапазон
    final radians = angle * math.pi / 180;

    // Активная дуга
    final paint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    const startAngle = -3 * math.pi / 4; // -135°
    final sweepAngle = (normalizedValue * 270) * math.pi / 180;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 5),
      startAngle,
      sweepAngle,
      false,
      paint,
    );

    // Индикатор (стрелка)
    final knobRadius = radius - 10;
    final knobX = center.dx + knobRadius * math.cos(radians);
    final knobY = center.dy + knobRadius * math.sin(radians);

    // Кружок на конце стрелки
    canvas.drawCircle(
      Offset(knobX, knobY),
      4,
      Paint()
        ..color = activeColor
        ..style = PaintingStyle.fill,
    );

    // Линия стрелки
    canvas.drawLine(
      center,
      Offset(knobX, knobY),
      Paint()
        ..color = activeColor
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
    );

    // Центральный кружок
    canvas.drawCircle(
      center,
      5,
      Paint()
        ..color = activeColor
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(RotaryKnobPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.inactiveColor != inactiveColor;
  }
}

