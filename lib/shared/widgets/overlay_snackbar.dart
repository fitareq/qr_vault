import 'dart:async';

import 'package:flutter/material.dart';

enum OverlayPosition {
  top,
  center,
  bottom,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  centerLeft,
  centerRight,
}

class OverlaySnackBar {
  static OverlayEntry? _currentOverlay;
  static Timer? _currentTimer;

  /// Shows a custom overlay snackbar that can be displayed over any widget
  /// including dialogs, bottom sheets, or when Scaffold is not available
  static void show(
    BuildContext context,
    String message, {
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
    OverlayPosition position = OverlayPosition.bottom,
    double? customTop,
    double? customBottom,
    double? customLeft,
    double? customRight,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    EdgeInsets? margin,
    TextStyle? textStyle,
    MainAxisAlignment? mainAxisAlignment,
    bool dismissible = true,
  }) {
    // Remove any existing overlay
    dismiss();

    final overlay = Overlay.of(context);

    // Calculate position based on enum or custom values
    final positionData = _calculatePosition(
      position,
      customTop: customTop,
      customBottom: customBottom,
      customLeft: customLeft,
      customRight: customRight,
    );

    _currentOverlay = OverlayEntry(
      builder:
          (context) => _OverlaySnackBarWidget(
            message: message,
            backgroundColor: backgroundColor ?? Colors.grey.shade800,
            textColor: textColor ?? Colors.white,
            icon: icon,
            bottom: positionData['bottom'],
            left: positionData['left'],
            right: positionData['right'],
            top: positionData['top'],
            alignment: positionData['alignment'],
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            padding:
                padding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: margin ?? EdgeInsets.zero,
            textStyle: textStyle,
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
            onDismiss: dismissible ? dismiss : null,
          ),
    );

    overlay.insert(_currentOverlay!);

    // Auto dismiss after duration
    _currentTimer = Timer(duration, dismiss);
  }

  /// Shows a success snackbar with green background
  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    OverlayPosition position = OverlayPosition.bottom,
  }) {
    show(
      context,
      message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      icon: Icons.check_circle,
      duration: duration,
      position: position,
    );
  }

  /// Shows an error snackbar with red background
  static void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    OverlayPosition position = OverlayPosition.bottom,
  }) {
    show(
      context,
      message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      icon: Icons.error,
      duration: duration,
      position: position,
    );
  }

  /// Shows a warning snackbar with orange background
  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    OverlayPosition position = OverlayPosition.bottom,
  }) {
    show(
      context,
      message,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      icon: Icons.warning,
      duration: duration,
      position: position,
    );
  }

  /// Shows an info snackbar with blue background
  static void showInfo(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    OverlayPosition position = OverlayPosition.bottom,
  }) {
    show(
      context,
      message,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      icon: Icons.info,
      duration: duration,
      position: position,
    );
  }

  /// Calculate position values based on enum
  static Map<String, dynamic> _calculatePosition(
    OverlayPosition position, {
    double? customTop,
    double? customBottom,
    double? customLeft,
    double? customRight,
  }) {
    // If custom values are provided, use them directly
    if (customTop != null ||
        customBottom != null ||
        customLeft != null ||
        customRight != null) {
      return {
        'top': customTop,
        'bottom': customBottom,
        'left': customLeft,
        'right': customRight,
        'alignment': Alignment.center,
      };
    }

    // Default margins from edges
    const double margin = 20.0;
    const double bottomMargin = 50.0;
    const double topMargin = 100.0;

    switch (position) {
      case OverlayPosition.top:
        return {
          'top': topMargin,
          'bottom': null,
          'left': margin,
          'right': margin,
          'alignment': Alignment.topCenter,
        };
      case OverlayPosition.center:
        return {
          'top': null,
          'bottom': null,
          'left': margin,
          'right': margin,
          'alignment': Alignment.center,
        };
      case OverlayPosition.bottom:
        return {
          'top': null,
          'bottom': bottomMargin,
          'left': margin,
          'right': margin,
          'alignment': Alignment.bottomCenter,
        };
      case OverlayPosition.topLeft:
        return {
          'top': topMargin,
          'bottom': null,
          'left': margin,
          'right': null,
          'alignment': Alignment.topLeft,
        };
      case OverlayPosition.topRight:
        return {
          'top': topMargin,
          'bottom': null,
          'left': null,
          'right': margin,
          'alignment': Alignment.topRight,
        };
      case OverlayPosition.bottomLeft:
        return {
          'top': null,
          'bottom': bottomMargin,
          'left': margin,
          'right': null,
          'alignment': Alignment.bottomLeft,
        };
      case OverlayPosition.bottomRight:
        return {
          'top': null,
          'bottom': bottomMargin,
          'left': null,
          'right': margin,
          'alignment': Alignment.bottomRight,
        };
      case OverlayPosition.centerLeft:
        return {
          'top': null,
          'bottom': null,
          'left': margin,
          'right': null,
          'alignment': Alignment.centerLeft,
        };
      case OverlayPosition.centerRight:
        return {
          'top': null,
          'bottom': null,
          'left': null,
          'right': margin,
          'alignment': Alignment.centerRight,
        };
    }
  }

  /// Manually dismiss the current overlay snackbar
  static void dismiss() {
    _currentTimer?.cancel();
    _currentTimer = null;
    _currentOverlay?.remove();
    _currentOverlay = null;
  }
}

class _OverlaySnackBarWidget extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final double? bottom;
  final double? left;
  final double? right;
  final double? top;
  final Alignment alignment;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final TextStyle? textStyle;
  final MainAxisAlignment mainAxisAlignment;
  final VoidCallback? onDismiss;

  const _OverlaySnackBarWidget({
    required this.message,
    required this.backgroundColor,
    required this.textColor,
    this.icon,
    this.bottom,
    this.left,
    this.right,
    this.top,
    required this.alignment,
    required this.borderRadius,
    required this.padding,
    required this.margin,
    this.textStyle,
    required this.mainAxisAlignment,
    this.onDismiss,
  });

  @override
  State<_OverlaySnackBarWidget> createState() => _OverlaySnackBarWidgetState();
}

class _OverlaySnackBarWidgetState extends State<_OverlaySnackBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        // Determine animation direction based on position
        Offset slideOffset;
        if (widget.top != null) {
          // Slide from top
          slideOffset = Offset(0, -50 * _slideAnimation.value);
        } else if (widget.bottom != null) {
          // Slide from bottom
          slideOffset = Offset(0, 50 * _slideAnimation.value);
        } else {
          // Center position - scale animation
          slideOffset = Offset.zero;
        }

        Widget snackBarContent = Transform.translate(
          offset: slideOffset,
          child: Transform.scale(
            scale:
                widget.top == null && widget.bottom == null
                    ? 0.8 + (0.2 * (1 - _slideAnimation.value))
                    : 1.0,
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  margin: widget.margin,
                  padding: widget.padding,
                  decoration: BoxDecoration(
                    color: widget.backgroundColor,
                    borderRadius: widget.borderRadius,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: widget.onDismiss,
                    borderRadius: widget.borderRadius,
                    child: Row(
                      mainAxisAlignment: widget.mainAxisAlignment,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(widget.icon, color: widget.textColor, size: 20),
                          const SizedBox(width: 8),
                        ],
                        Flexible(
                          child: Text(
                            widget.message,
                            style:
                                widget.textStyle?.copyWith(
                                  color: widget.textColor,
                                ) ??
                                TextStyle(
                                  color: widget.textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

        // Use Positioned if specific coordinates are provided
        if (widget.top != null ||
            widget.bottom != null ||
            widget.left != null ||
            widget.right != null) {
          return Positioned(
            top: widget.top,
            bottom: widget.bottom,
            left: widget.left,
            right: widget.right,
            child: snackBarContent,
          );
        }

        // Use Align for center positioning
        return Align(
          alignment: widget.alignment,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: snackBarContent,
          ),
        );
      },
    );
  }
}
