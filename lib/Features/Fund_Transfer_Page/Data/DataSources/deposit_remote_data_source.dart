import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../Core/Network/dio_client.dart';
import '../Models/deposits_model.dart';

@lazySingleton
class DepositRemoteDataSource {
  final Dio _dio;

  DepositRemoteDataSource({
    required DioClient dioClient,
  }) : _dio = dioClient.dio;

  Future<DepositsModel> getUserAllAccount() async{

    final response = await _dio.post("/api/deposits/get-all");

    return DepositsModel.fromJson(response.data);
  }
}