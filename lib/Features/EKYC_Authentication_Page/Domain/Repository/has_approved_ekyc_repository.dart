import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Data/Model/has_approved_ekyc.dart';
import '../../../../Core/Const/api_key.dart';
import '../../../../Core/Const/app_exception.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';

class HasApprovedEkycRepository {
  final dio = Dio();

  Future<HasApprovedEkycModel> getHasApprovedEkycRepository() async{
    final token = await LocalStorage.read('access_token');
    if (token == null) throw AppException('Token not found');

    try{

      final response = await dio.post(
        "${APIKey.baseUrl}/api/kycs/has-approved-kyc",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': token,
          },
        ),
      );

      if (response.statusCode == 200) {
        return HasApprovedEkycModel.fromJson(response.data);
      } else {
        throw AppException('خطا در ارتباط با سرور');
      }

    }catch (e) {
      rethrow;
    }
  }

}