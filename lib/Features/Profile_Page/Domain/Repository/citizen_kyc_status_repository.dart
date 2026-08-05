import 'package:dio/dio.dart';
import '../../../../Core/Const/api_key.dart';
import '../../../../Core/Const/app_exception.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';
import '../../Data/Model/citizen_kyc_status_model.dart';

class GetCitizenKycStatusRepository {
  final Dio dio = Dio();

  Future<bool> fetchEKYCStatus() async {
    final token = await LocalStorage.read('access_token');

    if (token == null) {
      throw AppException('Token not found');
    }

    try {
      final response = await dio.post(
        '${APIKey.baseUrl}/api/kycs/get-citizen-kyc-status',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': token,
          },
        ),
      );

      if (response.statusCode == 200) {
        final result = CitizenEkycStatusModel.fromJson(response.data);

        if (result.success != true || result.data == null) {
          return false;
        }

        return result.data!.hasApprovedKYC!;
      }

      return false;
    } on DioException catch (e) {
      print('Dio Error: ${e.response?.data}');
      return false;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}