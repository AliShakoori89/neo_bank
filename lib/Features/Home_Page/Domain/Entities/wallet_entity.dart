import 'package:equatable/equatable.dart';

class WalletEntity extends Equatable {
  final String? address;
  final String? title;
  final int? walletType;
  final bool? isActive;
  final int? balance;

  // سازنده اصلی
  WalletEntity({
    this.address,
    this.title,
    this.walletType,
    this.isActive,
    this.balance,
  });

  @override
  List<Object?> get props => [
    address,
    title,
    walletType,
    isActive,
    balance,
  ];
}