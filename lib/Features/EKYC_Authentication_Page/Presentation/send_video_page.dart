import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../Core/Spacing/app_space.dart';
import '../../../Core/Theme/app_colors.dart';
import '../../../Core/Widgets/app_snackbar.dart';
import '../../Home_Page/Presentation/Component/Charge_Internet_Page/Component/custom_header.dart';
import '../Data/Model/validate_token_model.dart';
import 'Bloc/Random_Text_Bloc/random_text_bloc.dart';
import 'Bloc/Random_Text_Bloc/random_text_event.dart';
import 'Bloc/Random_Text_Bloc/random_text_state.dart';
import 'Bloc/Send_Video_Bloc/send_video_bloc.dart';
import 'Bloc/Send_Video_Bloc/send_video_event.dart';
import 'Bloc/Send_Video_Bloc/send_video_state.dart';
import 'Component/camera_service.dart';
import 'Component/init_camera.dart';
import 'Component/random_text_widget.dart';
import 'Component/record_button_widget.dart';

class SendVideoPage extends StatefulWidget {
  const SendVideoPage({
    super.key,
    this.data,
  });

  final ValidateTokenDataModel? data;

  @override
  State<SendVideoPage> createState() => _SendVideoPageState();
}

class _SendVideoPageState extends State<SendVideoPage> {
  static const int _recordDuration = 5;

  final CameraService _cameraService = CameraService();

  CameraController? _cameraController;
  XFile? _recordedFile;

  bool _isCameraInitialized = false;
  bool _isRecording = false;
  bool _isSending = false;

  int _currentSecond = 0;
  String? _randomText;

  @override
  void initState() {
    super.initState();

    _loadRandomText();
    _initializeCamera();
  }

  void _loadRandomText() {
    context.read<RandomTextBloc>().add(
      GetRandomTextEvent(),
    );
  }

  Future<void> _initializeCamera() async {
    try {
      final controller = await CameraHelper.initCamera();

      if (!mounted) {
        await controller.dispose();
        return;
      }

      setState(() {
        _cameraController = controller;
        _isCameraInitialized = true;
      });
    } catch (error) {
      debugPrint('Camera initialization error: $error');
    }
  }

  Future<void> _startRecording() async {
    final controller = _cameraController;

    if (controller == null) {
      return;
    }

    setState(() {
      _isRecording = true;
      _currentSecond = 0;
    });

    final file = await _cameraService.startRecording(
      controller: controller,
      recordDuration: _recordDuration,
      onTick: _updateRecordingProgress,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isRecording = false;
      _recordedFile = file;
    });
  }

  Future<void> _stopRecording() async {
    final controller = _cameraController;

    if (controller == null) {
      return;
    }

    final file = await _cameraService.stopRecording(
      controller: controller,
    );

    if (!mounted || file == null) {
      return;
    }

    setState(() {
      _isRecording = false;
      _recordedFile = file;
    });
  }

  void _updateRecordingProgress(int second) {
    if (!mounted) {
      return;
    }

    setState(() {
      _currentSecond = second;
    });
  }

  Future<void> _sendVideo() async {
    if (_recordedFile == null) {
      _showError('لطفاً ابتدا ضبط ویدیو را انجام دهید.');
      return;
    }

    if (_randomText == null || _randomText!.isEmpty) {
      _showError('متن احراز هویت دریافت نشده است.');
      return;
    }

    setState(() {
      _isSending = true;
    });

    try {
      final bytes = await _recordedFile!.readAsBytes();
      final base64Video = base64Encode(bytes);

      if (!mounted) {
        return;
      }

      context.read<SendVideoBloc>().add(
        SendVideoWithTextEvent(
          content: base64Video,
          fileName: 'ekyc-video.mp4',
          randomText: _randomText!,
        ),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isSending = false;
      });

      _showError('خطا در آماده‌سازی ویدیو.');

      debugPrint('Send Video Error: $error');
    }
  }

  void _showError(String message) {
    if (!mounted) {
      return;
    }

    AppSnackBar.errorTop(
      context,
      message,
    );
  }

  void _handleSendVideoState(
    BuildContext context,
    SendVideoState state,
  ) {
    if (state.status == SendVideoStateStatus.error) {
      setState(() {
        _isSending = false;
      });

      AppSnackBar.errorTop(
        context,
        state.errorMessage,
      );
    }

    if (state.status == SendVideoStateStatus.success) {
      setState(() {
        _isSending = false;
      });

      AppSnackBar.successTop(
        context,
        'ویدیو با موفقیت ارسال شد',
      );

      context.go('/main_page', extra: 4);
    }
  }

  @override
  void dispose() {
    _cameraService.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<SendVideoBloc, SendVideoState>(
      listener: _handleSendVideoState,
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
                      _buildCameraPreview(),
                      _buildRecordingProgress(),
                      AppSpace.heightSpace_24,
                      _buildInstruction(),
                      AppSpace.heightSpace_12,
                      _buildRandomText(theme),
                      AppSpace.heightSpace_24,
                    ],
                  ),
                ),
              ),
              _buildRecordButton(),
              AppSpace.heightSpace_4,
              _buildSendButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCameraPreview() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        height: 340,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryFixed,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: _isCameraInitialized && _cameraController != null
              ? FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: _cameraController!.value.previewSize!.height,
                    height: _cameraController!.value.previewSize!.width,
                    child: CameraPreview(
                      _cameraController!,
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }

  Widget _buildRecordingProgress() {
    if (!_isRecording) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
        left: 16,
        right: 16,
      ),
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
    );
  }

  Widget _buildInstruction() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryFixed,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        'لطفاً پس از شروع ضبط، متن زیر را با صدای واضح بخوانید:',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildRandomText(ThemeData theme) {
    return BlocBuilder<RandomTextBloc, RandomTextState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          _randomText = state.randomText.data?.result?.first;

          return randomTextWidget(
            theme,
            _randomText,
          );
        }

        if (state.status.isLoading) {
          return const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Center(
          child: Text(
            state.errorMessage,
            style: const TextStyle(
              color: AppColors.redColor,
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecordButton() {
    return recordButtonWidget(
      _isSending,
      _isRecording,
      _stopRecording,
      _startRecording,
    );
  }

  Widget _buildSendButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: _isSending ? null : _sendVideo,
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
    );
  }
}
