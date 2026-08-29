// lib/Core/Utils/custom_refresh_button.dart
import 'package:flutter/material.dart';

class RefreshButtonWithAnimation extends StatefulWidget {
  final VoidCallback onPressed; // تغییر از VoidCallback به Function
  final Color? color;
  final double size;

  const RefreshButtonWithAnimation({
    super.key,
    required this.onPressed,
    this.color,
    this.size = 24,
  });

  @override
  State<RefreshButtonWithAnimation> createState() => _RefreshButtonWithAnimationState();
}

class _RefreshButtonWithAnimationState extends State<RefreshButtonWithAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onPressed() async { // تغییر به async اما Future<void>
    if (_isLoading) return;

    setState(() => _isLoading = true);
    _animationController.repeat();

    try {
      widget.onPressed(); // حذف await چون VoidCallback است
      // اگر عملیات async نیاز دارید، صبر کنید
      await Future.delayed(const Duration(milliseconds: 500)); // زمان برای دیدن انیمیشن
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      if (mounted) {
        _animationController.stop(); // حذف await
        _animationController.reset(); // حذف await
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: RotationTransition(
        turns: _animationController,
        child: Icon(
          Icons.refresh,
          color: widget.color ?? (_isLoading ? Colors.blue : null),
          size: widget.size,
        ),
      ),
      onPressed: _isLoading ? null : _onPressed,
      tooltip: 'بروزرسانی',
    );
  }
}