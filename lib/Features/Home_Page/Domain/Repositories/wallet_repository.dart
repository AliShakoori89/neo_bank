
import '../Entities/wallet_entity.dart';

abstract class WalletRepository {

  Future<List<WalletEntity>> getWalletDetails();
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
  Future<List<WalletEntity>> getActiveWallets();
}