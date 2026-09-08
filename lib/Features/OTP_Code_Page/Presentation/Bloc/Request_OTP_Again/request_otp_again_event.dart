import 'package:equatable/equatable.dart';

abstract class RequerstOtpAgainEvent extends Equatable {
  const RequerstOtpAgainEvent();

  @override
  List<Object> get props => [];
}

class RequestOTPCodeAgainEvent extends RequerstOtpAgainEvent {
  final String nationalCode;
  final String phoneNumber;

  const RequestOTPCodeAgainEvent({
    required this.nationalCode,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [nationalCode, phoneNumber];
}
