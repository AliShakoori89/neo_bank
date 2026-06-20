import 'package:equatable/equatable.dart';

abstract class ValidateTokenEvent extends Equatable {
  const ValidateTokenEvent();

  @override
  List<Object?> get props => [];
}

class ValidateTokenResponseEvent extends ValidateTokenEvent {
  final String tokenValue;
  final int orderId;
  final String tokenExpirationDateTime;

  const ValidateTokenResponseEvent({
    required this.tokenValue,
    required this.orderId,
    required this.tokenExpirationDateTime
  });

  @override
  List<Object?> get props => [
    tokenValue,
    orderId,
    tokenExpirationDateTime
  ];
}