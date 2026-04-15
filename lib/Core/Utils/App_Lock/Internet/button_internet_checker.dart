import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

class ButtonInternetChecker {
  static bool _isBannerVisible = false;
  static OverlayEntry? _overlayEntry;


  static Future<void> checkInternet({
    required BuildContext context,
    required VoidCallback onSuccess,
  }) async {

    bool hasInternet = false;

    try {

      print("START REQUEST");


      final request = await HttpClient()
          .getUrl(Uri.parse("https://www.tala.ir/favicon.ico"))
          .timeout(const Duration(seconds: 5));
      print("REQUEST SENT");

      final response = await request.close()
          .timeout(const Duration(seconds: 5));

      print("STATUS: ${response.statusCode}");

      if (response.statusCode == 200) {
        hasInternet = true;
      }

    } catch (e, s) {
      print("ERROR: $e");
      print("STACK: $s");
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
    return Positioned(
      top: 20,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: _animation,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(
                maxWidth: 500, // عرض حداکثر
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: Colors.red.shade600.withAlpha((0.85 * 255).toInt()),

                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 12,
                    color: Colors.black26,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min, // 👈 مهم
                    children: [
                    const Icon(Icons.wifi_off, color: Colors.white),
                    const SizedBox(width: 12),
                    const Flexible(
                      child: Text(
                        "اتصال اینترنت برقرار نیست",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],),
                  _isLoading
                      ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : GestureDetector(
                    onTap: _handleRetry,
                    child: const Text(
                      "تلاش مجدد",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
