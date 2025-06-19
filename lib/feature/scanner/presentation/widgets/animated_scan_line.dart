import 'package:flutter/material.dart';

class AnimatedScanLine extends StatefulWidget {
  final double width;
  final double height;
  final bool isVertical; // true for QR, false for barcode

  const AnimatedScanLine({
    super.key,
    required this.width,
    required this.height,
    this.isVertical = true,
  });

  @override
  State<AnimatedScanLine> createState() => _AnimatedScanLineState();
}

class _AnimatedScanLineState extends State<AnimatedScanLine>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (_, __) {
          final line = Container(
            width: widget.isVertical ? widget.width : 2,
            height: widget.isVertical ? 2 : widget.height,
            color: Colors.redAccent.withOpacity(0.85),
          );

          return Stack(
            children: [
              Positioned(
                top: widget.isVertical ? _animation.value * widget.height : 0,
                left: widget.isVertical ? 0 : _animation.value * widget.width,
                child: line,
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() => _controller.dispose();
}
