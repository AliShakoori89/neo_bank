import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/wallet_model.dart';
import '../../../../Core/Const/api_key.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';

class WalletRepository {

  final dio = Dio();

  Future<WalletResponseModel> getWalletDetails() async{

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

      if (response.statusCode == 200 && response.data != null) {
        final WalletResponseModel walletResponse =
        WalletResponseModel.fromJson(response.data);

        if (walletResponse.success) {
          return walletResponse;
        } else {
          throw Exception('خطا در دریافت اطلاعات کیف پول: ${walletResponse.error ?? 'خطای ناشناخته'}');
        }
      } else {
        throw Exception('خطا در دریافت اطلاعات کیف پول: ${response.statusCode}');
      }
    } catch (e) {
      print('خطا در دریافت اطلاعات کیف پول: $e');
      rethrow;
    }
  }


  /// خرید بسته اینترنت (نیاز به اصلاح بر اساس API واقعی)
  Future<Map<String, dynamic>> buyInternetPackage({
    required String sourceMobileNumber,
    required String walletAddress,
    required int productCode,
    required String destMobileNumber,
  }) async {
    final token = await LocalStorage.read('access_token');
    if (token == null) throw Exception('Token not found');

    final body = {
      "sourceMobileNumber": sourceMobileNumber,
      "walletAddress": walletAddress,
      "productCode": productCode,
      "destMobileNumber": destMobileNumber,
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
        return response.data;
      } else {
        throw Exception('خطا در خرید بسته اینترنت: ${response.statusCode}');
      }
    } catch (e) {
      print('خطا در خرید بسته اینترنت: $e');
      rethrow;
    }
  }

  /// دریافت موجودی کیف پول خاص (هلوپر متد)
  Future<int?> getWalletBalance(String walletAddress) async {
    try {
      final response = await getWalletDetails();
      final wallet = response.data.firstWhere(
            (wallet) => wallet.address == walletAddress,
        orElse: () => throw Exception('کیف پول مورد نظر یافت نشد'),
      );
      return wallet.balance;
    } catch (e) {
      print('خطا در دریافت موجودی کیف پول: $e');
      rethrow;
    }
  }

  /// دریافت کیف پول فعال (isActive = true)
  Future<List<WalletModel>> getActiveWallets() async {
    try {
      final response = await getWalletDetails();
      return response.data.where((wallet) => wallet.isActive).toList();
    } catch (e) {
      print('خطا در دریافت کیف پول‌های فعال: $e');
      rethrow;
    }
  }

}