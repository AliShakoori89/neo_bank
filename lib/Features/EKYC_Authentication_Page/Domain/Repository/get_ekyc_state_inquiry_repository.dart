import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Data/Model/get_ekyc_state_inquiry_model.dart';
import '../../../../Core/Const/api_key.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';

class GetEkycStateInquiryRepository {
  final dio = Dio();

  Future<GetEkycStateInquiryModel> getEKYCStateInquiryRepository() async{
    final token = await LocalStorage.read('access_token');
    if (token == null) throw Exception('Token not found');

    try{

      final response = await dio.post(
        "${APIKey.baseUrl}/api/kycs/get-kyc-state-inquiry",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': token,
          },
        ),
      );

      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 200) {
        return GetEkycStateInquiryModel.fromJson(response.data);
      } else {
        throw Exception('خطا در ارتباط با سرور');
      }

    }catch (e) {
      rethrow;
    }
  }

}