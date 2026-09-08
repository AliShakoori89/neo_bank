import '../Entities/wallet_entity.dart';
import '../Repositories/wallet_repository.dart';

class WalletUseCase {
  final WalletRepository walletRepository;

  WalletUseCase({required this.walletRepository});

  Future<List<WalletEntity>> getWalletDetails(){
    return walletRepository.getWalletDetails();
  }

  Future<Map<String, dynamic>> buyInternetPackage({
    required String sourceMobileNumber,
    required String walletAddress,
    required int productCode,
    required String destMobileNumber,
  }){
    return walletRepository.buyInternetPackage(
        sourceMobileNumber: sourceMobileNumber,
        walletAddress: walletAddress,
        productCode: productCode,
        destMobileNumber: destMobileNumber);
  }

  Future<int?> getWalletBalance(String walletAddress){
    return walletRepository.getWalletBalance(walletAddress);
  }

  Future<List<WalletEntity>> getActiveWallets(){
    return walletRepository.getActiveWallets();
  }
}