import 'dart:async';
import 'package:dio/dio.dart';
import '../../../../Core/Const/api_key.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';
import '../../Data/Model/get_citizen_kyc_status_model.dart';

class GetCitizenKycStatusRepository {
  final dio = Dio();

  // FutureOr<bool> fetchEKYCStatus() async {
  //
  //   final token = await LocalStorage.read('access_token');
  //   if (token == null) throw Exception('Token not found');
  //
  //   try {
  //
  //     final response = await dio.post(
  //       "${APIKey.baseUrl}/api/kycs/get-citizen-kyc-status",
  //       options: Options(
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Accept": "application/json",
  //           'Authorization': token,
  //         },
  //       ),
  //     );
  //
  //     if (response.statusCode == 200) {
  //
  //     }
  //
  //
  //   } catch (e) {
  //
  //   }
  // }
}