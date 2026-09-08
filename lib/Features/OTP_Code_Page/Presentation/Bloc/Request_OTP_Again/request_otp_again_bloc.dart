import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank/Features/OTP_Code_Page/Presentation/Bloc/Request_OTP_Again/request_otp_again_event.dart';
import 'package:neo_bank/Features/OTP_Code_Page/Presentation/Bloc/Request_OTP_Again/request_otp_again_state.dart';

import '../../../Domain/UseCases/request_otp_code_again_use_case.dart';

class RequestOtpAgainBloc
    extends Bloc<RequerstOtpAgainEvent, RequestOtpAgainState> {
  final RequestOtpCodeAgainUseCase requestOtpCodeAgainUseCase;

  RequestOtpAgainBloc({required this.requestOtpCodeAgainUseCase})
    : super(RequestOtpAgainState.initial()) {
    on<RequestOTPCodeAgainEvent>(_onRequestOtpAgain);
  }

  Future<void> _onRequestOtpAgain(
    RequestOTPCodeAgainEvent event,
    Emitter<RequestOtpAgainState> emit,
  ) async {
    try {
      emit(state.copyWith(status: RequestOtpAgainStatus.loading));

      final result = await requestOtpCodeAgainUseCase.requestOTPAgain(nationalNumber: event.nationalCode, mobileNumber: event.phoneNumber);

      emit(
        state.copyWith(
          status: RequestOtpAgainStatus.success,
          loginStatus: result.success,
          loginMessage: result.message,
          secretKey: result.secretKey,
          deviceId: result.deviceId,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: RequestOtpAgainStatus.error));
    }
  }
}
