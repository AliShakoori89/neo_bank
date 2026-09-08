import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

import '../../Widgets/app_snack_bar_with_button.dart';

class CheckInternetWhenPressButton {
  static bool _isBannerVisible = false;
  static OverlayEntry? _overlayEntry;


  static Future<void> checkInternet({
    required BuildContext context,
    required VoidCallback onSuccess,
  }) async {

    bool hasInternet = false;

    try {
      final request = await HttpClient()
          .getUrl(Uri.parse("http://10.170.1.27:9000/swagger/index.html"))
          .timeout(const Duration(seconds: 5));

      final response = await request.close()
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        hasInternet = true;
      }
    } catch (e) {
      debugPrint("ERROR: $e");
      hasInternet = false;
    }

    if (hasInternet) {
      if (_isBannerVisible) {
        _overlayEntry?.remove();
        _overlayEntry = null;
        _isBannerVisible = false;
      }
      onSuccess();
      return;
    }

    if (!context.mounted) return;

    if (!_isBannerVisible) {
      _showTopBanner(
        context: context,
        onRetry: () {
          checkInternet(
            context: context,
            onSuccess: onSuccess,
          );
        },
      );
    }
  }

  static void _showTopBanner({
    required BuildContext context,
    required VoidCallback onRetry,
  }) {
    _isBannerVisible = true;

    final overlay = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (context) => _TopInternetBanner(
        onRetry: onRetry,
        onClose: () {
          _overlayEntry?.remove();
          _overlayEntry = null;
          _isBannerVisible = false;
        },
      ),
    );

    overlay.insert(_overlayEntry!);
  }
}

class _TopInternetBanner extends StatefulWidget {
  final VoidCallback onRetry;
  final VoidCallback onClose;

  const _TopInternetBanner({
    required this.onRetry,
    required this.onClose,
  });

  @override
  State<_TopInternetBanner> createState() => _TopInternetBannerState();
}

class _TopInternetBannerState extends State<_TopInternetBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  bool _isLoading = false;
  Timer? _autoCloseTimer;


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();

    // 🔥 بستن خودکار بعد 4 ثانیه
    _autoCloseTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) {
        closeWithAnimation();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _autoCloseTimer?.cancel();

    super.dispose();
  }

  Future<void> _handleRetry() async {

    _autoCloseTimer?.cancel(); // جلوگیری از بسته شدن وسط عملیات

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(milliseconds: 300));

    widget.onRetry();

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> closeWithAnimation() async {
    _autoCloseTimer?.cancel();

    await _controller.reverse();

    if (mounted) {
      widget.onClose();
    }
  }


  @override
  Widget build(BuildContext context) {
    return AppSnackBarWithButton(
        errorText: "اتصال اینترنت برقرار نیست",
        isLoading: _isLoading,
        handleRetry: _handleRetry,
        animation: _animation);
  }
}
