import 'package:injectable/injectable.dart';
import '../Repositories/user_login_auth_repository.dart';

@lazySingleton
class CheckLoginStatusUseCase {
  final UserLoginAuthRepository repository;

  CheckLoginStatusUseCase({
    required this.repository,
  });

  Future<bool> call() {
    return repository.userIsLogin();
  }
}