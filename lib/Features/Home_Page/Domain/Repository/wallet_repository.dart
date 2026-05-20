import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/wallet_model.dart';
import '../../../../Core/Const/api_key.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';

class WalletRepository {

  final dio = Dio();

  Future<List<WalletModel>> getWalletDetails() async{

    final token = await LocalStorage.read('access_token');
    if (token == null) throw Exception('Token not found');

    try {
      final response = await dio.post(
        "${APIKey.baseUrl}/api/wallets/get-all",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': token,
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        List<WalletModel> packages = data
            .map((json) => WalletModel.fromJson(json))
            .toList();

        return packages;
      } else {
        throw Exception('خطا در دریافت اطلاعات کیف پول: ${response.statusCode}');
      }
    } catch (e) {
      print('خطا در دریافت اطلاعات کیف پول: $e');
      rethrow;
    }
  }

  Future buyInternetPackage() async{
    final token = await LocalStorage.read('access_token');
    if (token == null) throw Exception('Token not found');

    final body = {
      "sourceMobileNumber": "09122362803",
      "walletAddress": "string",
      "productCode": 200093,
      "destMobileNumber": "string"
    };

    try {
      final response = await dio.post(
        "${APIKey.baseUrl}/api/internetpackages/buy",
        data: jsonEncode(body),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': token,
          },
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        List<WalletModel> packages = data
            .map((json) => WalletModel.fromJson(json))
            .toList();

        return packages;
      } else {
        throw Exception('خطا در دریافت اطلاعات کیف پول: ${response.statusCode}');
      }
    } catch (e) {
      print('خطا در دریافت اطلاعات کیف پول: $e');
      rethrow;
    }
  }

}