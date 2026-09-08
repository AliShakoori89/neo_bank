import 'package:injectable/injectable.dart';
import '../Entities/otp_request_again_result_entity.dart';
import '../Repositories/request_otp_code_again_repository.dart';

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