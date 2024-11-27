import 'package:flutter/material.dart';

class CornerFlair extends StatelessWidget {
  final double size;
  final Color color;
  final bool left;

  // const CornerFlair(
  //     {super.key, required this.left, required this.size, required this.color});

  const CornerFlair.topLeft(
      {super.key, required this.size, required this.color})
      : left = true;

  const CornerFlair.topRight(
      {super.key, required this.size, required this.color})
      : left = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: left ? 0 : null,
      right: left ? null : 0,
      child: CustomPaint(
        size: Size(size, size), // Size of the trapezium
        painter: _TrapeziumPainter(color: color, left: left),
      ),
    );
  }
}

class _TrapeziumPainter extends CustomPainter {
  final bool left;
  final Color color;

  _TrapeziumPainter({required this.color, required this.left});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Path path = Path();
    if (left) {
      path.moveTo(0, size.width * 0.5);
      path.lineTo(size.width * 0.5, 0);
      path.lineTo(size.width, 0);
      path.lineTo(0, size.height);
      path.close();
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width * 0.5, 0);
      path.lineTo(size.width, size.width * 0.5);
      path.lineTo(size.width, size.height);
      path.close();
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
