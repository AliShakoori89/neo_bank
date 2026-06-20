import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../Core/Const/app_space.dart';
import '../../../main.dart';
import '../../Home_Page/Presentation/Component/Charge_Internet_Page/Component/custom_header.dart';
import 'Component/video_recorder_page.dart';

class SendVideoPage extends StatelessWidget {
  const SendVideoPage({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryFixed,
      body: SafeArea(
        child: Column(
          children: [
            const CustomHeader(
              title: 'احراز هویت',
              hasBackArrow: true,
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppSpace.heightSpace_16,

                    const Text(
                      'ضبط ویدیو احراز هویت',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    AppSpace.heightSpace_24,

                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onPrimaryFixed,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.face_retouching_natural,
                            size: 80,
                            color: theme.appBarTheme.titleTextStyle?.color,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'صورت خود را در این محدوده قرار دهید',
                            style: TextStyle(
                              color: theme.appBarTheme.titleTextStyle?.color,
                            ),
                          ),
                        ],
                      ),
                    ),

                    AppSpace.heightSpace_24,

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onPrimaryFixed,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'لطفاً پس از شروع ضبط، متن زیر را با صدای واضح بخوانید:',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    AppSpace.heightSpace_12,

                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.appBarTheme.titleTextStyle!.color!,
                        ),
                      ),
                      child: const Text(
                        'اینجانب درخواست احراز هویت غیرحضوری خود را با آگاهی کامل ثبت نموده و صحت اطلاعات ارائه‌شده را تأیید می‌کنم.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.8,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    AppSpace.heightSpace_24,

                    const Text(
                      'نکات مهم:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    AppSpace.heightSpace_12,

                    const _GuideItem(
                      text: 'در محیطی با نور مناسب قرار بگیرید.',
                    ),
                    const _GuideItem(
                      text: 'از عینک آفتابی، ماسک و کلاه استفاده نکنید.',
                    ),
                    const _GuideItem(
                      text: 'صورت شما باید کاملاً مشخص باشد.',
                    ),
                    const _GuideItem(
                      text: 'ویدیو بدون قطع شدن ضبط شود.',
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final frontCamera = cameras.firstWhere(
                          (camera) =>
                      camera.lensDirection == CameraLensDirection.front,
                    );

                    final File? recordedVideo =
                    await Navigator.push<File>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VideoRecorderPage(
                          camera: frontCamera,
                        ),
                      ),
                    );

                    if (recordedVideo != null) {
                      debugPrint(recordedVideo.path);

                      // آپلود ویدیو به سرور
                    }
                  },
                  icon: const Icon(Icons.videocam),
                  label: const Text('شروع ضبط ویدیو'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GuideItem extends StatelessWidget {
  final String text;

  const _GuideItem({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            size: 18,
            color: Colors.green,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}