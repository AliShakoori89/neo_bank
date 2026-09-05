import 'dart:async';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Data/Models/otp_request_result_model.dart';

abstract class OtpCodeCheckRepository {

  Future<OtpRequestResultModel> otpLogin(
    String otpCode,
    String secretKey,
    String deviceID,
  );
}