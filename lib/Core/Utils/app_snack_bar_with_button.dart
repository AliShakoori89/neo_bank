import 'package:flutter/material.dart';

class AppSnackBarWithButton extends StatelessWidget {
  const AppSnackBarWithButton(
      {super.key,
    required this.errorText,
    required this.isLoading,
    required this.handleRetry, this.animation});

  final String errorText;
  final bool isLoading;
  final VoidCallback handleRetry;
  final Animation<Offset>? animation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: animation != null
              ? SlideTransition(
            position: animation!,
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
                          Flexible(
                            child: Text(
                              errorText,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],),
                      isLoading
                          ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : GestureDetector(
                        onTap: handleRetry,
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
          )
              : Center(
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
                        Flexible(
                          child: Text(
                            errorText,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],),
                    isLoading
                        ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : GestureDetector(
                      onTap: handleRetry,
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
          )
        ),
      ],
    );
  }
}
