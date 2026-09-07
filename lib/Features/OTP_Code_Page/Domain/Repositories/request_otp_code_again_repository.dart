import 'dart:async';
import '../Entities/otp_request_again_result_entity.dart';

abstract class RequestOtpCodeAgainRepository {


  Future<OtpRequestAgainResultEntity> requestOTPAgain(
    String nationalNumber,
    String mobileNumber,
  );
}