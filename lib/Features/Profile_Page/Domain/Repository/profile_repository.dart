import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Const/api_key.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Data/Model/profile_model.dart';

class GetProfileRepository {
  final dio = Dio();

  Future<ProfileModel> getProfileField() async {
    try {
      final token = await LocalStorage.read('access_token');
      if (token == null) throw Exception('Token not found');

      final response = await dio.post(
        "${APIKey.baseUrl}/api/customers/get-info",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': token,
          },
        ),
      );

      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch profile');
      }
    } catch (e) {
      rethrow; // Bloc خودش تصمیم بگیره
    }
  }
}
