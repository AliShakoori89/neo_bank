import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../Core/Network/dio_client.dart';
import '../Model/wallet_model.dart';

@lazySingleton
class WalletDataSource {
  final Dio _dio;

  WalletDataSource({
    required DioClient dioClient,
  }) : _dio = dioClient.dio;

  Future<WalletResponseModel> getWalletDetails() async{
    final response = await _dio.post("/api/wallets/get-all");

    return WalletResponseModel.fromJson(response.data);
  }

  Future<Map<String, dynamic>> buyInternetPackage({
    required String sourceMobileNumber,
    required String walletAddress,
    required int productCode,
    required String destMobileNumber,
  }) async {
    final body = {
      "sourceMobileNumber": sourceMobileNumber,
      "walletAddress": walletAddress,
      "productCode": productCode,
      "destMobileNumber": destMobileNumber,
    };

    final response = await _dio.post(
      "/api/internetpackages/buy",
      data: body,
    );

    return response.data as Map<String, dynamic>;
  }

}