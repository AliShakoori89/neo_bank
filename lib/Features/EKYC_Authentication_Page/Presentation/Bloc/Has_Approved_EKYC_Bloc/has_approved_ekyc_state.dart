import 'package:equatable/equatable.dart';

enum HasApprovedEkycStateStatus { initial, success, error, loading }

extension HasApprovedEkycStateStatusX on HasApprovedEkycStateStatus {
  bool get isInitial => this == HasApprovedEkycStateStatus.initial;
  bool get isSuccess => this == HasApprovedEkycStateStatus.success;
  bool get isError => this == HasApprovedEkycStateStatus.error;
  bool get isLoading => this == HasApprovedEkycStateStatus.loading;
}

class HasApprovedEkycState extends Equatable {
  const HasApprovedEkycState({
    required this.status,
    required this.hasApprovedKYC,
    required this.errorMessage,
  });

  static HasApprovedEkycState initial() => HasApprovedEkycState(
      status: HasApprovedEkycStateStatus.initial,
      hasApprovedKYC: false,
      errorMessage: ''
  );

  final HasApprovedEkycStateStatus status;
  final bool hasApprovedKYC;
  final String errorMessage;

  @override
  List<Object?> get props => [status, hasApprovedKYC, errorMessage];

  HasApprovedEkycState copyWith({
    HasApprovedEkycStateStatus? status,
    bool? hasApprovedKYC,
    String? errorMessage
  }) {
    return HasApprovedEkycState(
        status: status ?? this.status,
        hasApprovedKYC: hasApprovedKYC ?? this.hasApprovedKYC,
        errorMessage: errorMessage ?? this.errorMessage
    );
  }
}
