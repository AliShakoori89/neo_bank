import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Data/DataSources/otp_code_check_remote_data_source.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Domain/Entities/otp_request_result_entity.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Domain/Repositories/otp_code_check_repository.dart';
import '../../../../Core/Network/app_exception.dart';
import '../../../../Core/Services/token_storage_service.dart';

@LazySingleton(as: OtpCodeCheckRepository)
class OtpCodeCheckRepositoryImpl implements OtpCodeCheckRepository{

  final OtpCodeCheckRemoteDataSource otpCodeCheckRemoteDataSource;

  OtpCodeCheckRepositoryImpl({required this.otpCodeCheckRemoteDataSource});

  @override
  Future<OtpRequestResultEntity> otpLogin(
      String otpCode,
      String secretKey,
      String deviceID,
      ) async {

    try {

      final data = await otpCodeCheckRemoteDataSource.otpLogin(
          otpCode: otpCode,
          secretKey: secretKey,
          deviceID: deviceID);

      if (data.success == true) {
        await LocalStorageService.save('access_token', data.data!.token!);
        await LocalStorageService.save('access_token_expire_time', data.data!.expireAt!.toIso8601String());
        await LocalStorageService.save('user_name', data.data!.displayName!);
        await LocalStorageService.save('mobile_number', data.data!.mobileNumber!);

        return OtpRequestResultEntity(
          message: '',
          success: true,
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
}