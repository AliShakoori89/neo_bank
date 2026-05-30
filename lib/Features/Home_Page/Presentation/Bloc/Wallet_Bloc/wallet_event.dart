import 'package:equatable/equatable.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object?> get props => [];
}

class WalletDetailsPackagesEvent extends WalletEvent {
  const WalletDetailsPackagesEvent();
}

class BuyPackagesEvent extends WalletEvent {
  final String sourceMobileNumber;
  final String walletAddress;
  final int productCode;
  final String destMobileNumber;

  const BuyPackagesEvent({
    required this.sourceMobileNumber,
    required this.walletAddress,
    required this.productCode,
    required this.destMobileNumber,
  });

  @override
  List<Object?> get props => [
    sourceMobileNumber,
    walletAddress,
    productCode,
    destMobileNumber,
  ];
}