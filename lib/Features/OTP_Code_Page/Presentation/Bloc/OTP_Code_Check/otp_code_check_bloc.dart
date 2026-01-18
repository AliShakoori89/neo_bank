import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Domain/Repository/otp_code_check_repository.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Bloc/OTP_Code_Check/otp_code_check_event.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Bloc/OTP_Code_Check/otp_code_check_state.dart';

class OtpCodeCheckBloc extends Bloc<OtpCodeCheckEvent, OtpCodeCheckState> {
  OtpCodeCheckRepository otpCodeCheckRepository;

  OtpCodeCheckBloc(this.otpCodeCheckRepository)
    : super(OtpCodeCheckState.initial()) {
    on<OtpCodeCheckValueEvent>(_mapOtpCodeCheckValueEventToState);
  }

  void _mapOtpCodeCheckValueEventToState(
    OtpCodeCheckValueEvent event,
    Emitter<OtpCodeCheckState> emit,
  ) async {
    try {
      emit(state.copyWith(status: OtpCodeCheckStatus.loading));

      final otpLoginStatus = await otpCodeCheckRepository.otpLogin(
        event.otpCode,
        event.secretKey,
        event.deviceId,
      );

      emit(
        state.copyWith(
          status: OtpCodeCheckStatus.success,
          otpLoginStatus: otpLoginStatus![0],
          otpLoginMessage: otpLoginStatus[1],
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: OtpCodeCheckStatus.error));
    }
  }
}
