import 'package:flutter/material.dart';

class BarcodeScannerOverlay extends StatelessWidget {
  final double cutOutWidth;
  final double cutOutHeight;

  const BarcodeScannerOverlay({
    super.key,
    required this.cutOutWidth,
    required this.cutOutHeight,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BarcodeOverlayPainter(
        cutOutWidth: cutOutWidth,
        cutOutHeight: cutOutHeight,
        borderColor: Colors.black,
        borderWidth: 4,
      ),
      child: Container(),
    );
  }
}

class _BarcodeOverlayPainter extends CustomPainter {
  final double cutOutWidth;
  final double cutOutHeight;
  final Color borderColor;
  final double borderWidth;

  _BarcodeOverlayPainter({
    required this.cutOutWidth,
    required this.cutOutHeight,
    required this.borderColor,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.black.withOpacity(0.5)
          ..style = PaintingStyle.fill;

    final cutOutLeft = (size.width - cutOutWidth) / 2;
    final cutOutTop = (size.height - cutOutHeight) / 2;
    final cutOutRect = Rect.fromLTWH(
      cutOutLeft,
      cutOutTop,
      cutOutWidth,
      cutOutHeight,
    );

    // Draw the dimmed background
    final backgroundPath = Path.combine(
      PathOperation.difference,
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
      Path()..addRect(cutOutRect),
    );
    canvas.drawPath(backgroundPath, paint);

    // Draw white border around cutout
    final borderPaint =
        Paint()
          ..color = borderColor
          ..strokeWidth = borderWidth
          ..style = PaintingStyle.stroke;

    canvas.drawRect(cutOutRect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
