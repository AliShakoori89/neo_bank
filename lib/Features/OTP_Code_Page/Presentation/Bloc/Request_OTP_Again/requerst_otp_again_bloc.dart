import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Domain/Repository/request_otp_code_again_repository.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Bloc/Request_OTP_Again/requerst_otp_again_event.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Bloc/Request_OTP_Again/requerst_otp_again_state.dart';

class RequerstOtpAgainBloc
    extends Bloc<RequerstOtpAgainEvent, RequerstOtpAgainState> {
  final RequestOtpCodeAgainRepository repository;

  RequerstOtpAgainBloc(this.repository)
    : super(RequerstOtpAgainState.initial()) {
    on<RequestOTPCodeAgainEvent>(_onRequestOtpAgain);
  }

  Future<void> _onRequestOtpAgain(
    RequestOTPCodeAgainEvent event,
    Emitter<RequerstOtpAgainState> emit,
  ) async {
    try {
      emit(state.copyWith(status: RequerstOtpAgainStatus.loading));

      final result = await repository.requestOTPAgain(
        event.nationalCode,
        event.phoneNumber,
      );

      emit(
        state.copyWith(
          status: RequerstOtpAgainStatus.success,
          loginStatus: result.success,
          loginMessage: result.message,
          secretKey: result.secretKey,
          deviceId: result.deviceId,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: RequerstOtpAgainStatus.error));
    }
  }
}
