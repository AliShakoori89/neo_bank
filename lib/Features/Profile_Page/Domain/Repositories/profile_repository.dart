import 'package:injectable/injectable.dart';
import 'package:neo_bank_mehr_iran/Core/Services/token_storage_service.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Domain/Entities/profile_result_entity.dart';

@lazySingleton
class GetProfileRepository {

  Future<ProfileResultEntity> getProfileField() async {
    final userName = await LocalStorageService.read('user_name');
    final mobileNumber = await LocalStorageService.read('mobile_number');

    return ProfileResultEntity(
      userName: userName ?? '',
      mobileNumber: mobileNumber ?? '',
    );
  }
}