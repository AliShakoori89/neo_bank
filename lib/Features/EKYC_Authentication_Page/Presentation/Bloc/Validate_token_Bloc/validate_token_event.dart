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
  final String cardSerialNo;
  final String cardExpDate;

  const ValidateTokenResponseEvent({
    required this.tokenValue,
    required this.orderId,
    required this.tokenExpirationDateTime,
    required this.cardSerialNo,
    required this.cardExpDate
  });

  @override
  List<Object?> get props => [
    tokenValue,
    orderId,
    tokenExpirationDateTime,
    cardSerialNo,
    cardExpDate
  ];
}