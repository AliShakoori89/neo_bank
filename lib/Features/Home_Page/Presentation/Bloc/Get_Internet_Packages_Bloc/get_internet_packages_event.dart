import 'package:equatable/equatable.dart';

abstract class InternetPackageEvent extends Equatable {
  const InternetPackageEvent();

  @override
  List<Object?> get props => [];
}

// رویداد برای دریافت لیست بسته‌ها
class FetchInternetPackages extends InternetPackageEvent {
  final int operatorCode;
  final int packageTimeCode;
  final int simType;
  final String traffic;

  FetchInternetPackages({required this.operatorCode, required this.packageTimeCode, required this.simType, required this.traffic});
}