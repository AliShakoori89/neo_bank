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

  FetchInternetPackages({required this.operatorCode, required this.packageTimeCode, required this.simType, required this.traffic});
}