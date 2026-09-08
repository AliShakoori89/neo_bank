import 'package:equatable/equatable.dart';
import '../../../Data/Model/send_video_model.dart';

enum SendVideoStateStatus { initial, success, error, loading }

extension SendVideoStateStatusX on SendVideoStateStatus {
  bool get isInitial => this == SendVideoStateStatus.initial;
  bool get isSuccess => this == SendVideoStateStatus.success;
  bool get isError => this == SendVideoStateStatus.error;
  bool get isLoading => this == SendVideoStateStatus.loading;
}

class SendVideoState extends Equatable {
  const SendVideoState({
    required this.status,
    required this.sendVideo,
    required this.errorMessage,
  });

  static SendVideoState initial() => SendVideoState(
    status: SendVideoStateStatus.initial,
    sendVideo: SendVideoModel(),
    errorMessage: ''
  );

  final SendVideoStateStatus status;
  final SendVideoModel sendVideo;
  final String errorMessage;

  @override
  List<Object?> get props => [status, sendVideo, errorMessage];

  SendVideoState copyWith({
    SendVideoStateStatus? status,
    SendVideoModel? sendVideo,
    String? errorMessage
  }) {
    return SendVideoState(
      status: status ?? this.status,
        sendVideo: sendVideo ?? this.sendVideo,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}
