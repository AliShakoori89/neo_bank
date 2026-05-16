import 'package:equatable/equatable.dart';

import '../../Component/Charge_Internet_Page/Data/Model/internet_package_model.dart';


enum InternetPackageStatus {
  initial,
  success,
  error,
  loading,
}

extension InternetPackageStatusX on InternetPackageStatus {
  bool get isInitial => this == InternetPackageStatus.initial;
  bool get isSuccess => this == InternetPackageStatus.success;
  bool get isError => this == InternetPackageStatus.error;
  bool get isLoading => this == InternetPackageStatus.loading;
}

class InternetPackageState extends Equatable {
  const InternetPackageState({required this.status, required this.internetPackages});

  static InternetPackageState initial() =>
      InternetPackageState(status: InternetPackageStatus.initial, internetPackages: []);

  final InternetPackageStatus status;
  final List<InternetPackageModel>? internetPackages;

  @override
  List<Object?> get props => [status, internetPackages];

  InternetPackageState copyWith({
    InternetPackageStatus? status,
    List<InternetPackageModel>? internetPackages,
  }) {
    return InternetPackageState(
      status: status ?? this.status,
      internetPackages: internetPackages ?? this.internetPackages,
    );
  }
}
