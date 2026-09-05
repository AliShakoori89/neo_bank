import 'package:dio/dio.dart';
import '../Models/deposits_model.dart';

class DepositRemoteDataSource {
  final Dio dio;

  DepositRemoteDataSource({required this.dio});

  Future<DepositsModel> getUserAllAccount() async{

    final response = await dio.post("/api/deposits/get-all");

    return DepositsModel.fromJson(response.data);
  }
}