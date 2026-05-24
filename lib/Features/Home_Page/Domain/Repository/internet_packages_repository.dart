import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../Core/Const/api_key.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';
import '../../Data/Model/buy_internet_error_model.dart';
import '../../Data/Model/internet_package_model.dart';

class InternetPackagesRepository {

  final dio = Dio();

  Future<List<InternetPackageModel>> getAllInternetPackages(int operatorCode) async {
    final token = await LocalStorage.read('access_token');
    if (token == null) throw Exception('Token not found');

    final body = {
      "operatorCode": operatorCode,
    };

    try {
      final response = await dio.post(
        "${APIKey.baseUrl}/api/internetpackages/get-all",
        data: jsonEncode(body),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': token,
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        List<InternetPackageModel> packages = data
            .map((json) => InternetPackageModel.fromJson(json))
            .toList();
        return packages;
      } else {
        throw Exception('خطا در دریافت بسته‌های اینترنت: ${response.statusCode}');
      }
    } catch (e) {
      print('خطا در دریافت بسته‌های اینترنت: $e');
      rethrow;
    }
  }

  Future<List<InternetPackageModel>> getInternetPackages(
      int operatorCode,
      int packageTimeCode,
      int simType,
      String traffic
      ) async {
    final token = await LocalStorage.read('access_token');
    if (token == null) throw Exception('Token not found');

    final body = {
      "operatorCode": operatorCode,
      "packageTimeCode": packageTimeCode,
      "simType": simType,
      "traffic": traffic
    };

    try {
      final response = await dio.post(
        "${APIKey.baseUrl}/api/internetpackages/get-all",
        data: jsonEncode(body),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': token,
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        List<InternetPackageModel> packages = data
            .map((json) => InternetPackageModel.fromJson(json))
            .toList();
        return packages;
      } else {
        throw Exception('خطا در دریافت بسته‌های اینترنت: ${response.statusCode}');
      }
    } catch (e) {
      print('خطا در دریافت بسته‌های اینترنت: $e');
      rethrow;
    }
  }

  // متد خرید با پردازش صحیح خطاها
  Future<BuyInternetPackageResult> buyInternetPackage(
      String sourceMobileNumber,
      String walletAddress,
      int productCode,
      String destMobileNumber
      ) async {
    final token = await LocalStorage.read('access_token');
    if (token == null) return BuyInternetPackageResult.error('Token not found');

    final body = {
      "sourceMobileNumber": sourceMobileNumber,
      "walletAddress": walletAddress,
      "productCode": productCode,
      "destMobileNumber": destMobileNumber
    };

    try {
      final response = await dio.post(
        "${APIKey.baseUrl}/api/internetpackages/buy",
        data: jsonEncode(body),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': token,
          },
        ),
      );

      if (response.statusCode == 200) {
        // بررسی می‌کنیم که پاسخ JSON است یا String
        if (response.data is Map<String, dynamic>) {
          final jsonResponse = response.data as Map<String, dynamic>;

          // اگر خطا باشد
          if (jsonResponse.containsKey('success') && jsonResponse['success'] == false) {
            final errorModel = ServiceErrorModel.fromJson(jsonResponse);
            return BuyInternetPackageResult.failure(errorModel);
          }

          // اگر موفقیت آمیز باشد (می‌توانید ساختار پاسخ موفق را اینجا هندل کنید)
          return BuyInternetPackageResult.success();
        }
        // اگر پاسخ String ساده است (مثل '1234')
        else if (response.data is String) {
          return BuyInternetPackageResult.successWithData(response.data);
        }
        else {
          return BuyInternetPackageResult.success();
        }
      } else {
        return BuyInternetPackageResult.error('خطا در ارتباط با سرور: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Dio Error: ${e.message}');
      if (e.response?.data != null) {
        try {
          final errorModel = ServiceErrorModel.fromJson(e.response!.data);
          return BuyInternetPackageResult.failure(errorModel);
        } catch (_) {
          return BuyInternetPackageResult.error('خطا در ارتباط با سرور');
        }
      }
      return BuyInternetPackageResult.error('خطا در اتصال به اینترنت');
    } catch (e) {
      print('خطا در خرید بسته اینترنت: $e');
      return BuyInternetPackageResult.error('خطای ناشناخته رخ داده است');
    }
  }
}

// کلاس نتیجه خرید برای مدیریت بهتر وضعیت‌ها
class BuyInternetPackageResult {
  final bool isSuccess;
  final bool isFailure;
  final bool isError;
  final ServiceErrorModel? errorModel;
  final String? errorMessage;
  final String? data;

  BuyInternetPackageResult._({
    required this.isSuccess,
    required this.isFailure,
    required this.isError,
    this.errorModel,
    this.errorMessage,
    this.data,
  });

  // خرید موفق بدون دیتا
  factory BuyInternetPackageResult.success() {
    return BuyInternetPackageResult._(
      isSuccess: true,
      isFailure: false,
      isError: false,
    );
  }

  // خرید موفق با دیتا (مثل '1234')
  factory BuyInternetPackageResult.successWithData(String data) {
    return BuyInternetPackageResult._(
      isSuccess: true,
      isFailure: false,
      isError: false,
      data: data,
    );
  }

  // خطای تجاری (مثل errorCode 5001)
  factory BuyInternetPackageResult.failure(ServiceErrorModel error) {
    return BuyInternetPackageResult._(
      isSuccess: false,
      isFailure: true,
      isError: false,
      errorModel: error,
      errorMessage: error.errorMessage,
    );
  }

  // خطای فنی (اتصال، سرور و...)
  factory BuyInternetPackageResult.error(String message) {
    return BuyInternetPackageResult._(
      isSuccess: false,
      isFailure: false,
      isError: true,
      errorMessage: message,
    );
  }

  String getDisplayMessage() {
    if (isSuccess) return 'خرید با موفقیت انجام شد';
    if (isFailure && errorModel != null) {
      return '${errorModel!.errorMessage} (کد خطا: ${errorModel!.errorCode})';
    }
    return errorMessage ?? 'خطای ناشناخته';
  }
}