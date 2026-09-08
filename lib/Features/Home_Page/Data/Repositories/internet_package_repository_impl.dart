import 'package:dio/dio.dart';
import '../../../../Core/Network/app_exception.dart';
import '../../Domain/Repositories/internet_packages_repository.dart';
import '../Data_Sources/internet_packages_data_sources.dart';
import '../Model/internet_package_model.dart';

class InternetPackageRepositoryImpl implements InternetPackagesRepository{

  final InternetPackagesDataSources internetPackagesDataSources;

  InternetPackageRepositoryImpl({required this.internetPackagesDataSources});

  @override
  Future<List<InternetPackage>> getAllInternetPackages(int operatorCode)
  async {

    try {
      final data = await internetPackagesDataSources.getAllInternetPackages(operatorCode);

      return data;

    } on DioException catch (e) {
      if (e.error is AppException) throw e.error!;
      throw AppException(e.message ?? 'خطایی در ارتباط با سرور رخ داده است.');
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('خطای غیرمنتظره: $e');
    }
  }

  @override
  Future<List<InternetPackage>> getInternetPackages({
    required int operatorCode,
    required int packageTimeCode,
    required int simType,
    required String traffic,
  }) async {
    try {
      return await internetPackagesDataSources.getInternetPackages(
        operatorCode: operatorCode,
        packageTimeCode: packageTimeCode,
        simType: simType,
        traffic: traffic,
      );
    } on DioException catch (e) {
      throw AppException(
        e.message ?? 'خطایی در ارتباط با سرور رخ داده است.',
      );
    } catch (e) {
      if (e is AppException) rethrow;

      throw AppException(
        'خطای غیرمنتظره: $e',
      );
    }
  }

  @override
  Future<InternetPackageModel> buyInternetPackage({
    required String sourceMobileNumber,
    required String walletAddress,
    required int productCode,
    required String destMobileNumber,
  }) async {
    try {
      return await internetPackagesDataSources.buyInternetPackage(
        sourceMobileNumber: sourceMobileNumber,
        walletAddress: walletAddress,
        productCode: productCode,
        destMobileNumber: destMobileNumber,
      );
    } on DioException catch (e) {
      throw AppException(
        e.message ?? 'خطایی در ارتباط با سرور رخ داده است.',
      );
    } catch (e) {
      if (e is AppException) rethrow;

      throw AppException(
        'خطای غیرمنتظره: $e',
      );
    }
  }

}