import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Domain/UseCases/otp_code_check_use_case.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Bloc/OTP_Code_Check/otp_code_check_event.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Bloc/OTP_Code_Check/otp_code_check_state.dart';
import '../../../../../Core/Network/app_exception.dart';

@injectable
class OtpCodeCheckBloc extends Bloc<OtpCodeCheckEvent, OtpCodeCheckState> {
  final OtpCodeCheckUseCase otpCodeCheckUseCase;

  OtpCodeCheckBloc({required this.otpCodeCheckUseCase})
    : super(OtpCodeCheckState.initial()) {
    on<OtpCodeCheckValueEvent>(_mapOtpCodeCheckValueEventToState);
  }

  Future<void> _mapOtpCodeCheckValueEventToState(
      OtpCodeCheckValueEvent event,
      Emitter<OtpCodeCheckState> emit,
      ) async {
    try {
      emit(
        state.copyWith(
          status: OtpCodeCheckStatus.loading,
        ),
      );

      final otpLoginStatus = await otpCodeCheckUseCase.otpLogin(
        otpCode: event.otpCode,
        secretKey: event.secretKey,
        deviceID: event.deviceId,
      );

      emit(
        state.copyWith(
          status: OtpCodeCheckStatus.success,
          otpLoginStatus: otpLoginStatus.success,
          otpLoginMessage: otpLoginStatus.message,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: OtpCodeCheckStatus.error,
          otpLoginMessage: error is AppException
              ? error.message
              : 'خطایی در بررسی کد تأیید رخ داده است.',
        ),
      );
    }
  }
}
