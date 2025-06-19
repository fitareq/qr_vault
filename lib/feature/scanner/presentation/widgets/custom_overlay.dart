import 'package:flutter/material.dart';

class ScannerOverlay extends StatelessWidget {
  final double cutOutSize;

  const ScannerOverlay({super.key, required this.cutOutSize});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ScannerOverlayPainter(cutOutSize),
      size: Size.infinite,
    );
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  final double cutOutSize;

  _ScannerOverlayPainter(this.cutOutSize);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(0.5);
    final cutOutRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: cutOutSize,
      height: cutOutSize,
    );

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()..addRRect(RRect.fromRectXY(cutOutRect, 10, 10)),
      ),
      paint,
    );

    // Draw border
    final borderPaint =
        Paint()
          ..color = Colors.black
          ..strokeWidth = 4
          ..style = PaintingStyle.stroke;
    canvas.drawRRect(RRect.fromRectXY(cutOutRect, 10, 10), borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
