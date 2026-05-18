import 'package:equatable/equatable.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/wallet_model.dart';

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
  const WalletState({required this.status, required this.walletDetails});

  static WalletState initial() =>
      WalletState(status: WalletStateStatus.initial, walletDetails: []);

  final WalletStateStatus status;
  final List<WalletModel>? walletDetails;

  @override
  List<Object?> get props => [status, walletDetails];

  WalletState copyWith({
    WalletStateStatus? status,
    List<WalletModel>? walletDetails,
  }) {
    return WalletState(
      status: status ?? this.status,
      walletDetails: walletDetails ?? this.walletDetails,
    );
  }
}
