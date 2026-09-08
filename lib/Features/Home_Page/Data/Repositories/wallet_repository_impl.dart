import 'package:dio/dio.dart';
import '../../../../Core/Network/app_exception.dart';
import '../../Domain/Entities/wallet_entity.dart';
import '../../Domain/Repositories/wallet_repository.dart';
import '../Data_Sources/wallet_data_source.dart';

class WalletRepositoryImpl implements WalletRepository {

  final WalletDataSource walletDataSource;

  WalletRepositoryImpl({
    required this.walletDataSource,
  });

  @override
  Future<List<WalletEntity>> getWalletDetails() async {
    try {
      final result = await walletDataSource.getWalletDetails();

      if (result.success) {
        return result.data
            .map((wallet) => wallet.toEntity())
            .toList();
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
      final wallets  = await getWalletDetails();

      final wallet = wallets.firstWhere(
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
  Future<List<WalletEntity>> getActiveWallets() async {
    try {
      final wallets  = await getWalletDetails();

      return wallets
          .where((wallet) => wallet.isActive == true)
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