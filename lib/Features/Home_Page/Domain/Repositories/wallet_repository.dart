import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/wallet_model.dart';

abstract class WalletRepository {

  Future<WalletResponseModel> getWalletDetails();
  /// خرید بسته اینترنت
  Future<Map<String, dynamic>> buyInternetPackage({
    required String sourceMobileNumber,
    required String walletAddress,
    required int productCode,
    required String destMobileNumber,
  });
  /// دریافت موجودی کیف پول خاص
  Future<int?> getWalletBalance(String walletAddress);
  /// دریافت کیف پول فعال
  Future<List<WalletModel>> getActiveWallets();
}