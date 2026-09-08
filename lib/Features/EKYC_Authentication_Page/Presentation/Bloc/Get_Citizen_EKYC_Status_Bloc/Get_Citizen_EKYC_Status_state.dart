import 'package:equatable/equatable.dart';

enum GetCitizenEkycStatusStateStatus { initial, success, error, loading }

extension GetEkycStateInquiryStateStatusX on GetCitizenEkycStatusStateStatus {
  bool get isInitial => this == GetCitizenEkycStatusStateStatus.initial;
  bool get isSuccess => this == GetCitizenEkycStatusStateStatus.success;
  bool get isError => this == GetCitizenEkycStatusStateStatus.error;
  bool get isLoading => this == GetCitizenEkycStatusStateStatus.loading;
}

class GetCitizenEkycStatusState extends Equatable {
  const GetCitizenEkycStatusState({
    required this.status,
    required this.hasApprovedKYC,
    required this.state,
    required this.errorMessage,
  });

  static GetCitizenEkycStatusState initial() => GetCitizenEkycStatusState(
      status: GetCitizenEkycStatusStateStatus.initial,
      hasApprovedKYC: false,
      state: 1,
      errorMessage: ''
  );

  final GetCitizenEkycStatusStateStatus status;
  final bool hasApprovedKYC;
  final int state;
  final String errorMessage;

  @override
  List<Object?> get props => [status, hasApprovedKYC, state, errorMessage];

  GetCitizenEkycStatusState copyWith({
    GetCitizenEkycStatusStateStatus? status,
    bool? hasApprovedKYC,
    int? state,
    String? errorMessage
  }) {
    return GetCitizenEkycStatusState(
        status: status ?? this.status,
        hasApprovedKYC: hasApprovedKYC ?? this.hasApprovedKYC,
        state: state ?? this.state,
        errorMessage: errorMessage ?? this.errorMessage
    );
  }
}
