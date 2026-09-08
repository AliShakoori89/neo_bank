import 'dart:async';
import '../Entities/login_result.dart';

abstract class UserLoginAuthRepository {

  Future<LoginResult> userLogin(
    String nationalNumber,
    String mobileNumber,
  );

  Future<bool> userIsLogin() ;

}
