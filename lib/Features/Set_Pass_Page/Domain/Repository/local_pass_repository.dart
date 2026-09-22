import 'dart:async';
import 'package:injectable/injectable.dart';
import '../../../../Core/Services/token_storage_service.dart';

@lazySingleton
class LocalPassRepository {

  Future<void> setPass(String passField) async {
    await LocalStorageService.save(
      'local_password',
      passField,
    );
  }

  Future<String?> readPass() async {
    return LocalStorageService.read(
      'local_password',
    );
  }

  Future<bool> isFirstLogin() async {
    final localPass = await LocalStorageService.read(
      'local_password',
    );
    return localPass == null;
  }
}