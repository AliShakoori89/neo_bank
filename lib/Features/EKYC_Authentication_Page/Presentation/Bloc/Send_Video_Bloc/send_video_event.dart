import 'package:equatable/equatable.dart';

abstract class SendVideoEvent extends Equatable {
  const SendVideoEvent();

  @override
  List<Object?> get props => [];
}

class SendVideoWithTextEvent extends SendVideoEvent {
  final String randomText;
  final String fileName;
  final String content;

  const SendVideoWithTextEvent({
    required this.randomText,
    required this.fileName,
    required this.content,
  });

  @override
  List<Object?> get props => [
    randomText,
    fileName,
    content,
  ];
}