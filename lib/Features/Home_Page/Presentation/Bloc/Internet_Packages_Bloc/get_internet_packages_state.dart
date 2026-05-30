import 'package:equatable/equatable.dart';

import '../../../Data/Model/internet_package_model.dart';


enum InternetPackageStatus {
  initial,
  success,
  error,
  loading,
}

enum BuyStatus {
  idle,        // بدون عملیات
  loading,     // در حال خرید
  success,     // خرید موفق
  failure,     // خطای تجاری (مثل 5001)
  error,       // خطای فنی
}

extension InternetPackageStatusX on InternetPackageStatus {
  bool get isInitial => this == InternetPackageStatus.initial;
  bool get isSuccess => this == InternetPackageStatus.success;
  bool get isError => this == InternetPackageStatus.error;
  bool get isLoading => this == InternetPackageStatus.loading;
}

extension BuyStatusX on BuyStatus {
  bool get isIdle => this == BuyStatus.idle;
  bool get isLoading => this == BuyStatus.loading;
  bool get isSuccess => this == BuyStatus.success;
  bool get isFailure => this == BuyStatus.failure;
  bool get isError => this == BuyStatus.error;
}

class InternetPackageState extends Equatable {
  const InternetPackageState({
    required this.status,
    required this.internetPackages,
    required this.buyStatus,
    required this.buyResult,
    required this.errorMessage,
    required this.errorCode,});

  static InternetPackageState initial() => InternetPackageState(
    status: InternetPackageStatus.initial,
    internetPackages: [],
    buyStatus: BuyStatus.idle,
    buyResult: null,
    errorMessage: null,
    errorCode: null,
  );

  final InternetPackageStatus status;
  final List<InternetPackage>? internetPackages;
  final BuyStatus buyStatus;
  final String? buyResult;  // برای ذخیره نتیجه موفق (مثل شماره پیگیری)
  final String? errorMessage; // پیام خطا
  final int? errorCode; // کد خطا (مثل 5001)

  @override
  List<Object?> get props => [
    status,
    internetPackages,
    buyStatus,
    buyResult,
    errorMessage,
    errorCode
  ];

  InternetPackageState copyWith({
    InternetPackageStatus? status,
    List<InternetPackage>? internetPackages,
    BuyStatus? buyStatus,
    String? buyResult,
    String? errorMessage,
    int? errorCode,
  }) {
    return InternetPackageState(
      status: status ?? this.status,
      internetPackages: internetPackages ?? this.internetPackages,
      buyStatus: buyStatus ?? this.buyStatus,
      buyResult: buyResult ?? this.buyResult,
      errorMessage: errorMessage ?? this.errorMessage,
      errorCode: errorCode ?? this.errorCode,
    );
  }
}
