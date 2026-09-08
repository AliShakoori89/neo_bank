import 'package:injectable/injectable.dart';
import '../Entities/login_result.dart';
import '../Repositories/user_login_auth_repository.dart';

@lazySingleton
class LoginUseCase {
  final UserLoginAuthRepository repository;

  LoginUseCase({
    required this.repository,
  });

  Future<LoginResult> call({
    required String nationalNumber,
    required String mobileNumber,
  }) {
    return repository.userLogin(
      nationalNumber,
      mobileNumber,
    );
  }
}