import 'dart:async';

import '../Entities/otp_request_result_entity.dart';

abstract class OtpCodeCheckRepository {

  Future<OtpRequestResultEntity> otpLogin(
    String otpCode,
    String secretKey,
    String deviceID,
  );
}