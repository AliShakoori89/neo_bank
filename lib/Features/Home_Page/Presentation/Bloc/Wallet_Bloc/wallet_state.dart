import 'package:equatable/equatable.dart';
import '../../../Domain/Entities/wallet_entity.dart';

enum WalletStateStatus {
  initial,
  loading,
  success,
  error,
  purchaseSuccess
}

extension WalletStateStatusX on WalletStateStatus {
  bool get isInitial => this == WalletStateStatus.initial;
  bool get isLoading => this == WalletStateStatus.loading;
  bool get isSuccess => this == WalletStateStatus.success;
  bool get isError => this == WalletStateStatus.error;
  bool get isPurchaseSuccess => this == WalletStateStatus.purchaseSuccess;
}

class WalletState extends Equatable {
  final WalletStateStatus status;
  final List<WalletEntity> walletDetails;
  final String? traceId;
  final String? errorMessage;
  final Map<String, dynamic>? purchaseData;

  const WalletState({
    required this.status,
    required this.walletDetails,
    this.traceId,
    this.errorMessage,
    this.purchaseData,
  });

  static WalletState initial() {
    return const WalletState(
      status: WalletStateStatus.initial,
      walletDetails: [],
      traceId: null,
      errorMessage: null,
      purchaseData: null,
    );
  }

  WalletState copyWith({
    WalletStateStatus? status,
    List<WalletEntity>? walletDetails,
    String? traceId,
    String? errorMessage,
    Map<String, dynamic>? purchaseData,
  }) {
    return WalletState(
      status: status ?? this.status,
      walletDetails: walletDetails ?? this.walletDetails,
      traceId: traceId ?? this.traceId,
      errorMessage: errorMessage ?? this.errorMessage,
      purchaseData: purchaseData ?? this.purchaseData,
    );
  }

  @override
  List<Object?> get props => [
    status,
    walletDetails,
    traceId,
    errorMessage,
    purchaseData,
  ];
}