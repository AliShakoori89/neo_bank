import 'package:equatable/equatable.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/wallet_model.dart';

import '../../../Data/Model/internet_package_model.dart';


enum WalletStateStatus {
  initial,
  success,
  error,
  loading,
}

extension WalletStateStatusX on WalletStateStatus {
  bool get isInitial => this == WalletStateStatus.initial;
  bool get isSuccess => this == WalletStateStatus.success;
  bool get isError => this == WalletStateStatus.error;
  bool get isLoading => this == WalletStateStatus.loading;
}

class WalletState extends Equatable {
  const WalletState({required this.status, required this.internetPackages});

  static WalletState initial() =>
      WalletState(status: WalletStateStatus.initial, internetPackages: []);

  final WalletStateStatus status;
  final List<WalletModel>? internetPackages;

  @override
  List<Object?> get props => [status, internetPackages];

  WalletState copyWith({
    WalletStateStatus? status,
    List<WalletModel>? internetPackages,
  }) {
    return WalletState(
      status: status ?? this.status,
      internetPackages: internetPackages ?? this.internetPackages,
    );
  }
}
