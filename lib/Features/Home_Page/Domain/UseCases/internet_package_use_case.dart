import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Repositories/internet_packages_repository.dart';
import '../../Data/Model/internet_package_model.dart';

class InternetPackageUseCase {
  final InternetPackagesRepository repository;

  InternetPackageUseCase({required this.repository});

  Future<List<InternetPackage>> getAllInternetPackages(int operatorCode){
    return repository.getAllInternetPackages(operatorCode);
  }

  Future<List<InternetPackage>> getInternetPackages({
    required int operatorCode,
    required int packageTimeCode,
    required int simType,
    required String traffic,
  }){
    return repository.getInternetPackages(operatorCode: operatorCode, packageTimeCode: packageTimeCode, simType: simType, traffic: traffic);
  }

  Future<InternetPackageModel> buyInternetPackage({
    required String sourceMobileNumber,
    required String walletAddress,
    required int productCode,
    required String destMobileNumber,
  }){
    return repository.buyInternetPackage(sourceMobileNumber: sourceMobileNumber, walletAddress: walletAddress, productCode: productCode, destMobileNumber: destMobileNumber);
  }
}