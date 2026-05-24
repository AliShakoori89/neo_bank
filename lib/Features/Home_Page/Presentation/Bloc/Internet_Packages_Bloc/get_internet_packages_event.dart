import 'package:equatable/equatable.dart';

abstract class InternetPackageEvent extends Equatable {
  const InternetPackageEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllInternetPackages extends InternetPackageEvent {
  final int operatorCode;

  const FetchAllInternetPackages({required this.operatorCode});
}

class FetchInternetPackages extends InternetPackageEvent {
  final int operatorCode;
  final int packageTimeCode;
  final int simType;
  final String traffic;

  const FetchInternetPackages({required this.operatorCode, required this.packageTimeCode, required this.simType, required this.traffic});
}

// اضافه کردن رویداد خرید بسته اینترنت
class BuyInternetPackage extends InternetPackageEvent {
  final String sourceMobileNumber;
  final String walletAddress;
  final int productCode;
  final String destMobileNumber;

  const BuyInternetPackage({
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
    destMobileNumber
  ];
}

// رویداد برای ریست کردن وضعیت خرید
class ResetBuyStatus extends InternetPackageEvent {}