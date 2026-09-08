import 'package:equatable/equatable.dart';

enum GetEkycStateInquiryStateStatus { initial, success, error, loading }

extension GetEkycStateInquiryStateStatusX on GetEkycStateInquiryStateStatus {
  bool get isInitial => this == GetEkycStateInquiryStateStatus.initial;
  bool get isSuccess => this == GetEkycStateInquiryStateStatus.success;
  bool get isError => this == GetEkycStateInquiryStateStatus.error;
  bool get isLoading => this == GetEkycStateInquiryStateStatus.loading;
}

class GetEkycStateInquiryState extends Equatable {
  const GetEkycStateInquiryState({
    required this.status,
    required this.state,
    required this.errorMessage,
  });

  static GetEkycStateInquiryState initial() => GetEkycStateInquiryState(
    status: GetEkycStateInquiryStateStatus.initial,
    state: 1,
    errorMessage: ''
  );

  final GetEkycStateInquiryStateStatus status;
  final int state;
  final String errorMessage;

  @override
  List<Object?> get props => [status, state, errorMessage];

  GetEkycStateInquiryState copyWith({
    GetEkycStateInquiryStateStatus? status,
    bool? hasApprovedKYC,
    int? state,
    String? errorMessage
  }) {
    return GetEkycStateInquiryState(
      status: status ?? this.status,
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}
