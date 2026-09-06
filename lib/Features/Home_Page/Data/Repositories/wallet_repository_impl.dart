import 'package:dio/dio.dart';
import '../../../../Core/Network/app_exception.dart';
import '../../Data/Model/wallet_model.dart';
import '../../Domain/Repositories/wallet_repository.dart';
import '../Data_Sources/wallet_data_source.dart';

class WalletRepositoryImpl implements WalletRepository {

  final WalletDataSource walletDataSource;

  WalletRepositoryImpl({
    required this.walletDataSource,
  });

  @override
  Future<WalletResponseModel> getWalletDetails() async {
    try {
      final result = await walletDataSource.getWalletDetails();

      if (result.success) {
        return result;
      }

      throw AppException(
        result.error?.toString() ??
            'خطا در دریافت اطلاعات کیف پول',
      );
    } on DioException catch (e) {
      throw AppException(
        e.message ??
            'خطایی در ارتباط با سرور رخ داده است.',
      );
    } catch (e) {
      if (e is AppException) rethrow;

      throw AppException(
        'خطای غیرمنتظره: $e',
      );
    }
  }

  @override
  Future<Map<String, dynamic>> buyInternetPackage({
    required String sourceMobileNumber,
    required String walletAddress,
    required int productCode,
    required String destMobileNumber,
  }) async {
    try {
      return await walletDataSource.buyInternetPackage(
        sourceMobileNumber: sourceMobileNumber,
        walletAddress: walletAddress,
        productCode: productCode,
        destMobileNumber: destMobileNumber,
      );
    } on DioException catch (e) {
      throw AppException(
        e.message ??
            'خطایی در ارتباط با سرور رخ داده است.',
      );
    } catch (e) {
      if (e is AppException) rethrow;

      throw AppException(
        'خطای غیرمنتظره: $e',
      );
    }
  }

  @override
  Future<int?> getWalletBalance(
      String walletAddress,
      ) async {
    try {
      final response = await getWalletDetails();

      final wallet = response.data.firstWhere(
            (wallet) => wallet.address == walletAddress,
        orElse: () => throw AppException(
          'کیف پول مورد نظر یافت نشد',
        ),
      );

      return wallet.balance;
    } on DioException catch (e) {
      throw AppException(
        e.message ??
            'خطایی در ارتباط با سرور رخ داده است.',
      );
    } catch (e) {
      if (e is AppException) rethrow;

      throw AppException(
        'خطای غیرمنتظره: $e',
      );
    }
  }

  @override
  Future<List<WalletModel>> getActiveWallets() async {
    try {
      final response = await getWalletDetails();

      return response.data
          .where((wallet) => wallet.isActive)
          .toList();
    } on DioException catch (e) {
      throw AppException(
        e.message ??
            'خطایی در ارتباط با سرور رخ داده است.',
      );
    } catch (e) {
      if (e is AppException) rethrow;

      throw AppException(
        'خطای غیرمنتظره: $e',
      );
    }
  }
}