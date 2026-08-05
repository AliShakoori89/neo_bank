import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/wallet_model.dart';
import '../../../../Core/Const/app_exception.dart';

class WalletRepository {
  final Dio dio;

  WalletRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  Future<WalletResponseModel> getWalletDetails() async {
    try {
      final response = await dio.post("/api/wallets/get-all");

      if (response.statusCode == 200 && response.data != null) {
        final WalletResponseModel walletResponse = WalletResponseModel.fromJson(response.data);

        if (walletResponse.success) {
          return walletResponse;
        } else {
          throw AppException(walletResponse.error?.toString() ?? 'خطا در دریافت اطلاعات کیف پول');
        }
      } else {
        throw AppException('خطا در دریافت اطلاعات کیف پول');
      }
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error!;
      throw AppException(e.message ?? 'خطایی در ارتباط با سرور رخ داده است.');
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('خطای غیرمنتظره: $e');
    }
  }

  /// خرید بسته اینترنت
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

    try {
      final response = await dio.post(
        "/api/internetpackages/buy",
        data: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw AppException('خطا در خرید بسته اینترنت');
      }
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error!;
      throw AppException(e.message ?? 'خطایی در ارتباط با سرور رخ داده است.');
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('خطای غیرمنتظره: $e');
    }
  }

  /// دریافت موجودی کیف پول خاص
  Future<int?> getWalletBalance(String walletAddress) async {
    final response = await getWalletDetails();
    final wallet = response.data.firstWhere(
      (wallet) => wallet.address == walletAddress,
      orElse: () => throw AppException('کیف پول مورد نظر یافت نشد'),
    );
    return wallet.balance;
  }

  /// دریافت کیف پول فعال
  Future<List<WalletModel>> getActiveWallets() async {
    final response = await getWalletDetails();
    return response.data.where((wallet) => wallet.isActive).toList();
  }
}