import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Data/Model/get_citizen_ekyc_status_model.dart';
import '../../../../Core/Const/api_key.dart';
import '../../../../Core/Const/app_exception.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';

class GetCitizenEkycStatusRepository {
  final dio = Dio();

  Future<GetCitizenEkycStatusModel> getCitizenEkycStatus() async{
    final token = await LocalStorage.read('access_token');
    if (token == null) throw AppException('Token not found');

    try{

      final response = await dio.post(
        "${APIKey.baseUrl}/api/kycs/get-citizen-kyc-status",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': token,
          },
        ),
      );

      if (response.statusCode == 200) {
        return GetCitizenEkycStatusModel.fromJson(response.data);
      } else {
        throw AppException('خطا در ارتباط با سرور');
      }

    }catch (e) {
      rethrow;
    }
  }

}