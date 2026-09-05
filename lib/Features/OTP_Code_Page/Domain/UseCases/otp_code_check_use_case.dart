import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Domain/Repositories/otp_code_check_repository.dart';
import '../../Data/Models/otp_request_result_model.dart';

class OtpCodeCheckUseCase {
  final OtpCodeCheckRepository repository;

  OtpCodeCheckUseCase({
    required this.repository
  });

  Future<OtpRequestResultModel> otpLogin({
    required String otpCode,
    required String secretKey,
    required String deviceID}){
    return repository.otpLogin(otpCode, secretKey, deviceID);
  }
}