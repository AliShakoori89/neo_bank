import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart';
import 'package:neo_bank_mehr_iran/Core/Services/token_storage_service.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Domain/Entities/profile_result_entity.dart';

class GetProfileRepository {
  final Dio dio;

  GetProfileRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  Future<ProfileResultEntity> getProfileField() async {
    final userName = await LocalStorageService.read('user_name');
    final mobileNumber = await LocalStorageService.read('mobile_number');

    return ProfileResultEntity(
      userName: userName ?? '',
      mobileNumber: mobileNumber ?? '',
    );
  }
}