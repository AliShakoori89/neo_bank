import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../Core/Network/app_exception.dart';
import '../../../../Core/Services/token_storage_service.dart';
import '../../../../Core/Utils/DateTime/calculate_expire_time.dart';
import '../../Domain/Entities/login_result.dart';
import '../../Domain/Repositories/user_login_auth_repository.dart';
import '../Data_Sources/auth_remote_data_source.dart';

@LazySingleton(as: UserLoginAuthRepository)
class UserLoginAuthRepositoryImpl
    implements UserLoginAuthRepository {

  final AuthRemoteDataSource remoteDataSource;

  UserLoginAuthRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<LoginResult> userLogin(
      String nationalNumber,
      String mobileNumber,
      ) async {
    try {

      final data = await remoteDataSource.userLogin(
        nationalNumber: nationalNumber,
        mobileNumber: mobileNumber,
      );

      if (data.success == true) {
        // Debug prints for developer
        print('-----------------------------------------');
        print('OTP Code: ${data.data?.code}');
        print('Device ID: ${data.data?.deviceId}');
        print('Secret Key: ${data.data?.secretKey}');
        print('-----------------------------------------');

        LocalStorageService.save('secret_key', data.data!.secretKey!);
        LocalStorageService.save(
          'expire_secret_key_time',
          data.data!.expireTime!.toIso8601String(),
        );

        return LoginResult(
          success: true,
          message: '',
          secretKey: data.data!.secretKey!,
          deviceId: data.data!.deviceId!,
          expireTime: calculateExpireTime(data.data!.expireTime.toString()),
        );
      }

      throw AppException(data.error?.errorMessage ?? 'خطای نامشخص');
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error!;
      throw AppException(e.message ?? 'خطایی در ارتباط با سرور رخ داده است.');
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('خطای غیرمنتظره: $e');
    }
  }

  @override
  Future<bool> userIsLogin() {
    return LocalStorageService.isLoggedIn();
  }
}