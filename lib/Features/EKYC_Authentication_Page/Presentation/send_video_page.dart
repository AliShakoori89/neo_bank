import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/custom_button.dart';
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

  bool _isCameraStarted = false;
  CameraController? _controller;
  bool _isInitialized = false;
  bool _isRecording = false;
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
          if (state.status == SendVideoStateStatus.error) {
            AppSnackBar.errorTop(
              context,
              state.errorMessage,
            );
          }

          if (state.status == SendVideoStateStatus.success) {
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

                    Padding(
                      padding: EdgeInsets.only(left: 80, right: 80),
                      child: Container(
                        height: 340,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.onPrimaryFixed,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: !_isCameraStarted
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.face_6,
                                size: 80,
                                color: theme.appBarTheme.titleTextStyle?.color,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'صورت خود را در این محدوده قرار دهید',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: theme.appBarTheme.titleTextStyle?.color,
                                ),
                              ),
                            ],
                          )
                              : (_isInitialized && _controller != null)
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final previewSize = _controller?.value.previewSize;

                                if (previewSize == null) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                return FittedBox(
                                  fit: BoxFit.contain,
                                  child: SizedBox(
                                    width: previewSize.height,
                                    height: previewSize.width,
                                    child: CameraPreview(_controller!),
                                  ),
                                );
                              },
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
                      padding: EdgeInsets.all(16),
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
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.8,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }
                            if(state.status.isError){
                              return Center(
                                child: Text(state.errorMessage, style: TextStyle(
                                    color: AppColors.redColor
                                ),),
                              );
                            }
                            return Center(
                              child: Text(state.errorMessage, style: TextStyle(
                                  color: AppColors.redColor
                              ),),
                            );

                          }
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

            !_isCameraStarted
                ? Padding(
              padding: EdgeInsets.only(
                  left: 16,
                  right: 16
              ),
              child: SizedBox(
                width: double.infinity,
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
                  onPressed: () async {
                    setState(() {
                      _isCameraStarted = true;
                    });

                    await _initCamera();
                  },
                  icon: const Icon(Icons.videocam),
                  label: const Text('شروع ضبط ویدیو'),
                ),
              ),
            )
                : Padding(
              padding: EdgeInsets.only(
                  left: 16,
                  right: 16
              ),
              child: SizedBox(
                width: double.infinity,
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
                  onPressed: _isRecording
                      ? _stopRecording
                      : _startRecording,
                  icon: Icon(
                    _isRecording ? Icons.stop : Icons.fiber_manual_record,
                    color: Colors.red,
                  ),
                  label: Text(
                    _isRecording ? 'توقف ضبط' : 'شروع ضبط',
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                  left: 16,
                  right: 16
              ),
              child: CustomButton(
                  buttonTitle: 'تایید و ادامه',
                  buttonOnPressed: () async {

                    if (_recordedFile == null || randomText == null) {
                      return;
                    }
                    final bytes = await _recordedFile!.readAsBytes();
                    final base64Video = base64Encode(bytes);

                    try {
                      final decoded = base64Decode(base64Video);
                      print("decoded bytes: ${decoded.length}");
                    } catch (e) {
                      print("Base64 Error: $e");
                    }

                    final decoded = base64Decode(base64Video);

                    //**********************************

                    final dir = await getApplicationDocumentsDirectory();

                    final file = File('${dir.path}/base64.txt');

                    await file.writeAsString(base64Video);

                    print(file.path);
                    print(file.path);

                    //**********************************

                    context.read<SendVideoBloc>().add(
                      SendVideoWithTextEvent(
                        content: base64Video,
                        fileName: 'ekyc-video.mp4',
                        randomText: randomText!,
                      ),
                    );

                  }),
            )
          ],
        ),
      ),
    )
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