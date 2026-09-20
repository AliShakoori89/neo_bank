import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Data/DataSources/Request_otp_code_again_remote_data_source.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Domain/Entities/otp_request_again_result_entity.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Domain/Repositories/request_otp_code_again_repository.dart';
import '../../../../Core/Network/app_exception.dart';
import '../../../../Core/Services/token_storage_service.dart';

@LazySingleton(as: RequestOtpCodeAgainRepository)
class RequestOtpCodeAgainRepositoryImpl implements RequestOtpCodeAgainRepository{

  final RequestOtpCodeAgainRemoteDataSource requestOtpCodeAgainRemoteDataSource;

  RequestOtpCodeAgainRepositoryImpl({
    required this.requestOtpCodeAgainRemoteDataSource
  });

  @override
  Future<OtpRequestAgainResultEntity> requestOTPAgain(String nationalNumber,
      String mobileNumber,) async {
    try {

      final data = await requestOtpCodeAgainRemoteDataSource.requestOTPAgain(nationalNumber: nationalNumber, mobileNumber: mobileNumber);
      print('code                ');
      print(data.data!.code);

      if (data.success == true) {

        LocalStorageService.save('secret_key', data.data!.secretKey!);
        LocalStorageService.save(
          'expire_secret_key_time',
          data.data!.expireTime!.toIso8601String(),
        );

        return OtpRequestAgainResultEntity(
          success: true,
          message: '',
          secretKey: data.data!.secretKey!,
          deviceId: data.data!.deviceId!,
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