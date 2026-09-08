import 'package:injectable/injectable.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Domain/Repositories/request_otp_code_again_repository.dart';
import '../Entities/otp_request_again_result_entity.dart';

@lazySingleton
class RequestOtpCodeAgainUseCase {
  final RequestOtpCodeAgainRepository repository;

  RequestOtpCodeAgainUseCase({
    required this.repository
  });

  Future<OtpRequestAgainResultEntity> requestOTPAgain({
    required String nationalNumber,
    required String mobileNumber}){
    return repository.requestOTPAgain(nationalNumber, mobileNumber);
  }
}