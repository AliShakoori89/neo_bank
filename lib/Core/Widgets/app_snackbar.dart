import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

enum SnackBarType { success, error, info, warning }

class AppSnackBar {
  AppSnackBar._();

  static void errorTop(BuildContext context, String message) {
    _show(context, message, SnackBarType.error);
  }

  static void successTop(BuildContext context, String message) {
    _show(context, message, SnackBarType.success);
  }

  static void infoTop(BuildContext context, String message) {
    _show(context, message, SnackBarType.info);
  }

  static void warningTop(BuildContext context, String message) {
    _show(context, message, SnackBarType.warning);
  }

  static void _show(BuildContext context, String message, SnackBarType type) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => _SnackBarWidget(
        message: message,
        type: type,
        onDismiss: () => entry.remove(),
      ),
    );

    overlay.insert(entry);
  }
}

class _SnackBarWidget extends StatefulWidget {
  final String message;
  final SnackBarType type;
  final VoidCallback onDismiss;

  const _SnackBarWidget({
    required this.message,
    required this.type,
    required this.onDismiss,
  });

  @override
  State<_SnackBarWidget> createState() => _SnackBarWidgetState();
}

class _SnackBarWidgetState extends State<_SnackBarWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ));

    _controller.forward();

    _timer = Timer(const Duration(seconds: 4), () {
      _dismiss();
    });
  }

  void _dismiss() {
    _controller.reverse().then((_) => widget.onDismiss());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color baseColor;
    IconData icon;

    switch (widget.type) {
      case SnackBarType.success:
        baseColor = const Color(0xFF079455);
        icon = Icons.check_circle_outline_rounded;
        break;
      case SnackBarType.error:
        baseColor = const Color(0xFFD92D20);
        icon = Icons.error_outline_rounded;
        break;
      case SnackBarType.warning:
        baseColor = const Color(0xFFDC6803);
        icon = Icons.warning_amber_rounded;
        break;
      case SnackBarType.info:
        baseColor = const Color(0xFF1570EF);
        icon = Icons.info_outline_rounded;
        break;
    }

    return Positioned(
      top: MediaQuery.of(context).padding.top + 12,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _offsetAnimation,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dy < -10) {
                  _dismiss();
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: baseColor.withAlpha(isDark ? 20 : 85),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: baseColor.withAlpha(30),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: baseColor.withAlpha(20),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(20),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _getTitle(widget.type),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.message,
                                style: TextStyle(
                                  color: Colors.white.withAlpha(90),
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getTitle(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return 'موفقیت‌آمیز';
      case SnackBarType.error:
        return 'خطا';
      case SnackBarType.warning:
        return 'هشدار';
      case SnackBarType.info:
        return 'اطلاعیه';
    }
  }
}
