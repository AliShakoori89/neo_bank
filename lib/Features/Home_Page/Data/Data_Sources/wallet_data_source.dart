import 'package:dio/dio.dart';

import '../Model/wallet_model.dart';

class WalletDataSource {
  final Dio dio;

  WalletDataSource({
    required this.dio,
  });

  Future<WalletResponseModel> getWalletDetails() async{
    final response = await dio.post("/api/wallets/get-all");

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

    final response = await dio.post(
      "/api/internetpackages/buy",
      data: body,
    );

    return response.data as Map<String, dynamic>;
  }

}