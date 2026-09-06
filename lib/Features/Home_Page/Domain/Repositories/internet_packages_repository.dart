import '../../Data/Model/internet_package_model.dart';

abstract class InternetPackagesRepository {

  /// دریافت همه بسته‌های اینترنت بر اساس کد اپراتور
  Future<List<InternetPackage>> getAllInternetPackages(int operatorCode);

  /// دریافت بسته‌های اینترنت با فیلترهای مختلف
  Future<List<InternetPackage>> getInternetPackages({
    required int operatorCode,
    required int packageTimeCode,
    required int simType,
    required String traffic,
  });

  /// خرید بسته اینترنت
  Future<InternetPackageModel> buyInternetPackage({
    required String sourceMobileNumber,
    required String walletAddress,
    required int productCode,
    required String destMobileNumber,
  });
}