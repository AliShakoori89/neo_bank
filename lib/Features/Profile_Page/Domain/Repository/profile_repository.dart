import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Data/Model/profile_result_model.dart';

class GetProfileRepository {
  final dio = Dio();

  Future<ProfileResultModel> getProfileField() async {
    final userName = await LocalStorage.read('user_name');
    final mobileNumber = await LocalStorage.read('mobile_number');

    return ProfileResultModel(
      userName: userName ?? '',
      mobileNumber: mobileNumber ?? '',
    );
  }
}
