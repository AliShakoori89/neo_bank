import 'dart:async';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Domain/Entities/otp_request_result_entity.dart';

abstract class OtpCodeCheckRepository {

  Future<OtpRequestResultEntity> otpLogin(
    String otpCode,
    String secretKey,
    String deviceID,
  );
}