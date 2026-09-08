import 'package:dio/dio.dart';

import '../../../../Core/Network/dio_client.dart';
import '../../../../Core/Services/token_storage_service.dart';
import '../Entities/profile_result_entity.dart';

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