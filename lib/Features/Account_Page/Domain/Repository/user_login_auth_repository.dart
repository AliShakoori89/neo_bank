import 'dart:async';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Domain/Entities/login_result.dart';

abstract class UserLoginAuthRepository {

  Future<LoginResult> userLogin(
    String nationalNumber,
    String mobileNumber,
  );

  Future<bool> userIsLogin() ;

}
