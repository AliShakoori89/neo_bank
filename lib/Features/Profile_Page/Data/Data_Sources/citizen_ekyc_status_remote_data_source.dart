import 'package:dio/dio.dart';
import '../Model/citizen_kyc_status_model.dart';

class CitizenEkycStatusRemoteDataSource {

  final Dio dio;

  CitizenEkycStatusRemoteDataSource({required this.dio});

  Future<CitizenEkycStatusModel> fetchEKYCStatus() async {
    final response = await dio.post('/api/kycs/get-citizen-kyc-status');
    print('STATUS: ${response.statusCode}');
    print('DATA: ${response.data}');
    print('HEADERS: ${response.headers}');
    return CitizenEkycStatusModel.fromJson(response.data);
  }
}