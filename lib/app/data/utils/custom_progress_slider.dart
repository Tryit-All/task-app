import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomProgressSlider extends StatefulWidget {
  final double value;
  final double taskStart;
  final double taskDuration;
  final double cellWidth;
  final ValueChanged<double>? onChanged;

  const CustomProgressSlider({
    Key? key,
    required this.value,
    required this.taskStart,
    required this.taskDuration,
    required this.cellWidth,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomProgressSlider> createState() => _CustomProgressSliderState();
}

class _CustomProgressSliderState extends State<CustomProgressSlider> {
  late double _dragValue;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _dragValue = widget.value;
  }

  void _handleDragStart(DragStartDetails details) {
    _isDragging = true;
    _updateValue(details.localPosition);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;
    _updateValue(details.localPosition);
  }

  void _handleDragEnd(DragEndDetails details) {
    _isDragging = false;
    widget.onChanged?.call(_dragValue);
  }

  void _updateValue(Offset localPosition) {
    final totalWidth = widget.taskDuration * widget.cellWidth;
    final rawValue = (localPosition.dx) / totalWidth;

    // Constrain the value between 0.0 and 1.0
    _dragValue = rawValue.clamp(0.0, 1.0);

    widget.onChanged?.call(_dragValue);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: widget.taskStart * widget.cellWidth +
          (widget.taskDuration * widget.cellWidth * widget.value),
      child: GestureDetector(
        onHorizontalDragStart: _handleDragStart,
        onHorizontalDragUpdate: _handleDragUpdate,
        onHorizontalDragEnd: _handleDragEnd,
        child: CustomPaint(
          size: const Size(10, 10),
          painter: TrianglePainter(),
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
