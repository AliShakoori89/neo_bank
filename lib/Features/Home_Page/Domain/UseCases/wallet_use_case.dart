import '../../Data/Model/wallet_model.dart';
import '../Repositories/wallet_repository.dart';

class WalletUseCase {
  final WalletRepository walletRepository;

  WalletUseCase({required this.walletRepository});

  Future<WalletResponseModel> getWalletDetails(){
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

  Future<List<WalletModel>> getActiveWallets(){
    return walletRepository.getActiveWallets();
  }
}