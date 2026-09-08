import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../Core/Network/dio_client.dart';
import '../Model/citizen_kyc_status_model.dart';

@lazySingleton
class CitizenEkycStatusRemoteDataSource {

  final Dio _dio;

  CitizenEkycStatusRemoteDataSource({
    required DioClient dioClient,
  }) : _dio = dioClient.dio;

  Future<CitizenEkycStatusModel> fetchEKYCStatus() async {
    final response = await _dio.post('/api/kycs/get-citizen-kyc-status');
    print('STATUS: ${response.statusCode}');
    print('DATA: ${response.data}');
    print('HEADERS: ${response.headers}');
    return CitizenEkycStatusModel.fromJson(response.data);
  }
}