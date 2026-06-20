import 'package:equatable/equatable.dart';

abstract class CreateTokenEvent extends Equatable {
  const CreateTokenEvent();

  @override
  List<Object?> get props => [];
}

class CreateTokenResponseEvent extends CreateTokenEvent {
  final String cardSerialNo;
  final String cardExpDate;

  const CreateTokenResponseEvent({
    required this.cardSerialNo,
    required this.cardExpDate,
  });

  @override
  List<Object?> get props => [
    cardSerialNo,
    cardExpDate
  ];
}