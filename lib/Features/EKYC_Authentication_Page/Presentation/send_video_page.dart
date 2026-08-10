import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Presentation/Bloc/Random_Text_Bloc/random_text_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Presentation/Bloc/Random_Text_Bloc/random_text_event.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Presentation/Bloc/Random_Text_Bloc/random_text_state.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Presentation/Bloc/Send_Video_Bloc/send_video_bloc.dart';
import 'package:path_provider/path_provider.dart';
import '../../../Core/Const/app_space.dart';
import '../../../Core/Utils/app_snackbar.dart';
import '../../../main.dart';
import '../../Home_Page/Presentation/Component/Charge_Internet_Page/Component/custom_header.dart';
import '../Data/Model/validate_token_model.dart';
import 'Bloc/Send_Video_Bloc/send_video_event.dart';
import 'Bloc/Send_Video_Bloc/send_video_state.dart';

class SendVideoPage extends StatefulWidget {
  const SendVideoPage({super.key, this.data});

  final ValidateTokenDataModel? data;

  @override
  State<SendVideoPage> createState() => _SendVideoPageState();
}

class _SendVideoPageState extends State<SendVideoPage> {

  CameraController? _controller;
  bool _isInitialized = false;
  bool _isRecording = false;
  bool _isSending = false;
  XFile? _recordedFile;
  final int _recordDuration = 5;
  int _currentSecond = 0;
  Timer? _timer;
  String? randomText;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<RandomTextBloc>(context).add(GetRandomTextEvent());
    print(randomText);

    _initCamera();
  }

  Future<void> _initCamera() async {
    final frontCamera = cameras.firstWhere(
          (c) => c.lensDirection == CameraLensDirection.front,
    );

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.low,
      enableAudio: true,
    );

    await _controller!.initialize();

    if (!mounted) return;

    setState(() {
      _isInitialized = true;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    await _controller!.startVideoRecording();

    setState(() {
      _isRecording = true;
      _currentSecond = 0;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      setState(() {
        _currentSecond++;
      });

      if (_currentSecond >= _recordDuration) {
        await _stopRecording();
        timer.cancel();
      }
    });
  }

  Future<void> _stopRecording() async {
    if (_controller == null || !_controller!.value.isRecordingVideo) return;

    _timer?.cancel();

    final file = await _controller!.stopVideoRecording();

    setState(() {
      _isRecording = false;
      _recordedFile = file;
    });

    debugPrint("Video saved at: ${file.path}");
  }


  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return BlocListener<SendVideoBloc, SendVideoState>(
        listener: (context, state) {

          // -----------------------------
          // خطا
          // -----------------------------
          if (state.status == SendVideoStateStatus.error) {
            if (mounted) {
              setState(() {
                _isSending = false;
              });
            }

            AppSnackBar.errorTop(
              context,
              state.errorMessage,
            );
          }

          // -----------------------------
          // موفقیت
          // -----------------------------
          if (state.status == SendVideoStateStatus.success) {
            if (mounted) {
              setState(() {
                _isSending = false;
              });
            }

            AppSnackBar.successTop(
              context,
              "ویدیو با موفقیت ارسال شد",
            );
          }
        },
        child: Scaffold(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        height: 340,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.onPrimaryFixed,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: (_isInitialized && _controller != null)
                              ? FittedBox(
                            fit: BoxFit.contain,
                            child: SizedBox(
                              width: _controller!.value.previewSize!.height,
                              height: _controller!.value.previewSize!.width,
                              child: CameraPreview(_controller!),
                            ),
                          )
                              : const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),

                    if (_isRecording) ...[
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            LinearProgressIndicator(
                              value: _currentSecond / _recordDuration,
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '$_currentSecond / $_recordDuration ثانیه',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

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
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.appBarTheme.titleTextStyle!.color!,
                        ),
                      ),
                      child: BlocBuilder<RandomTextBloc, RandomTextState>(
                          builder: (context, state) {
                            if(state.status.isLoading){
                              return const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            if(state.status.isSuccess){

                              randomText = state.randomText.data!.result!.first;

                              return Text(
                                state.randomText.data!.result!.first,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.8,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }
                            return Center(
                              child: Text(state.errorMessage, style: const TextStyle(
                                  color: AppColors.redColor
                              ),),
                            );
                          }
                      ),
                    ),

                    AppSpace.heightSpace_24,
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    shape:
                    WidgetStateProperty.all<
                        RoundedRectangleBorder
                    >(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          7.0,
                        ), // Adjust for desired corner radius
                      ),
                    ),
                  ),
                  onPressed: _isSending
                      ? null
                      : (_isRecording
                      ? _stopRecording
                      : _startRecording),
                  icon: Icon(
                    _isRecording
                        ? Icons.stop
                        : Icons.fiber_manual_record,
                    color: Colors.red,
                  ),
                  label: Text(
                    _isRecording ? 'توقف ضبط' : 'شروع ضبط',
                  ),
                ),
              ),
            ),
            AppSpace.heightSpace_4,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(

                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      AppColors.splashGradiantColor1,
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                  onPressed: _isSending
                      ? null
                      : () async {
                    // --------------------------------
                    // ویدیو ضبط نشده
                    // --------------------------------
                    if (_recordedFile == null) {
                      if (context.mounted) {
                        AppSnackBar.errorTop(
                          context,
                          'لطفاً ابتدا ضبط ویدیو را انجام دهید.',
                        );
                      }
                      return;
                    }

                    // --------------------------------
                    // جلوگیری از کلیک مجدد
                    // --------------------------------
                    setState(() {
                      _isSending = true;
                    });

                    try {
                      final bytes = await _recordedFile!.readAsBytes();
                      final base64Video = base64Encode(bytes);

                      if (randomText == null || randomText!.isEmpty) {
                        if (mounted) {
                          setState(() {
                            _isSending = false;
                          });
                        }

                        if (context.mounted) {
                          AppSnackBar.errorTop(
                            context,
                            'متن احراز هویت دریافت نشده است.',
                          );
                        }

                        final bytes = await _recordedFile!.readAsBytes();
                        final base64Video = base64Encode(bytes);

                        try {
                          base64Decode(base64Video);
                        } catch (e) {
                          debugPrint("Base64 Error: $e");
                        }

                        //**********************************

                        final dir = await getApplicationDocumentsDirectory();
                        final file = File('${dir.path}/base64.txt');
                        await file.writeAsString(base64Video);

                        return;
                      }

                      if (context.mounted) {
                        context.read<SendVideoBloc>().add(
                          SendVideoWithTextEvent(
                            content: base64Video,
                            fileName: 'ekyc-video.mp4',
                            randomText: randomText!,
                          ),
                        );
                      }
                    } catch (e) {
                      if (mounted) {
                        setState(() {
                          _isSending = false;
                        });
                      }

                      if (context.mounted) {
                        AppSnackBar.errorTop(
                          context,
                          'خطا در آماده‌سازی ویدیو.',
                        );
                      }

                      debugPrint(
                        'Send Video Error: $e',
                      );
                    }
                  },
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: _isSending
                            ? const SizedBox(
                          key: ValueKey('loading'),
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor:
                            AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                            : const Text(
                          'تایید و ادامه',
                          key: ValueKey('text'),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),          ],
        ),
      ),
    )
    );
  }
}
