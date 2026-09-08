import 'package:flutter/material.dart';

Widget recordButtonWidget(
    isSending,
    isRecording,
    stopRecording,
    startRecording){
  return Padding(
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
        onPressed: isSending
            ? null
            : (isRecording
            ? stopRecording
            : startRecording),
        icon: Icon(
          isRecording
              ? Icons.stop
              : Icons.fiber_manual_record,
          color: Colors.red,
        ),
        label: Text(
          isRecording ? 'توقف ضبط' : 'شروع ضبط',
        ),
      ),
    ),
  );
}