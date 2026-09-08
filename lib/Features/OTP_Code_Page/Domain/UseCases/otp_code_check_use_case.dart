import 'package:injectable/injectable.dart';
import '../Entities/otp_request_result_entity.dart';
import '../Repositories/otp_code_check_repository.dart';

@lazySingleton
class OtpCodeCheckUseCase {
  final OtpCodeCheckRepository repository;

  OtpCodeCheckUseCase({
    required this.repository
  });

  Future<OtpRequestResultEntity> otpLogin({
    required String otpCode,
    required String secretKey,
    required String deviceID}){
    return repository.otpLogin(otpCode, secretKey, deviceID);
  }
}