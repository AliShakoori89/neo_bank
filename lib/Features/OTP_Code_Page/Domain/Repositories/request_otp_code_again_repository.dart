import 'dart:async';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Data/Models/otp_request_again_result_model.dart';

abstract class RequestOtpCodeAgainRepository {


  Future<OtpRequestAgainResultModel> requestOTPAgain(
    String nationalNumber,
    String mobileNumber,
  );
}