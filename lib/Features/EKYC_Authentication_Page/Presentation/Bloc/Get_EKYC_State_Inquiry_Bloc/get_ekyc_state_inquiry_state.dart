import 'package:equatable/equatable.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Data/Model/get_ekyc_state_inquiry_model.dart';

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
    required this.ekycStateResponse,
    required this.errorMessage,
  });

  static GetEkycStateInquiryState initial() => GetEkycStateInquiryState(
    status: GetEkycStateInquiryStateStatus.initial,
    ekycStateResponse: GetEkycStateInquiryModel(),
    errorMessage: ''
  );

  final GetEkycStateInquiryStateStatus status;
  final GetEkycStateInquiryModel ekycStateResponse;
  final String errorMessage;

  @override
  List<Object?> get props => [status, ekycStateResponse, errorMessage];

  GetEkycStateInquiryState copyWith({
    GetEkycStateInquiryStateStatus? status,
    GetEkycStateInquiryModel? ekycStateResponse,
    String? errorMessage
  }) {
    return GetEkycStateInquiryState(
      status: status ?? this.status,
      ekycStateResponse: ekycStateResponse ?? this.ekycStateResponse,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}
