import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart';
import '../../../../Core/Const/app_exception.dart';
import '../../Data/Model/internet_package_model.dart';

class InternetPackagesRepository {
  final Dio _dio;

  InternetPackagesRepository({Dio? dio}) : _dio = dio ?? DioClient().dio;

  /// دریافت همه بسته‌های اینترنت بر اساس کد اپراتور
  Future<List<InternetPackage>> getAllInternetPackages(int operatorCode) async {
    final body = {
      "operatorCode": operatorCode,
    };

    try {
      final response = await _dio.post(
        "/api/internetpackages/get-all",
        data: jsonEncode(body),
      );

      if (response.statusCode == 200 && response.data != null) {
        if (response.data is Map<String, dynamic>) {
          final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;

          if (responseData['success'] == false) {
            throw AppException(responseData['error']?['errorMessage'] ?? 'خطا در دریافت بسته‌ها');
          }

          if (responseData['data'] is List) {
            final List<dynamic> data = responseData['data'] as List<dynamic>;
            return data.map((json) => InternetPackage.fromJson(json as Map<String, dynamic>)).toList();
          }
        } else if (response.data is List) {
          final List<dynamic> data = response.data as List<dynamic>;
          return data.map((json) => InternetPackage.fromJson(json as Map<String, dynamic>)).toList();
        }
        return [];
      } else {
        throw AppException('خطا در دریافت بسته‌های اینترنت');
      }
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error!;
      throw AppException(e.message ?? 'خطایی در ارتباط با سرور رخ داده است.');
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('خطای غیرمنتظره: $e');
    }
  }

  /// دریافت بسته‌های اینترنت با فیلترهای مختلف
  Future<List<InternetPackage>> getInternetPackages({
    required int operatorCode,
    required int packageTimeCode,
    required int simType,
    required String traffic,
  }) async {
    final body = {
      "operatorCode": operatorCode,
      "packageTimeCode": packageTimeCode,
      "simType": simType,
      "traffic": traffic,
    };

    try {
      final response = await _dio.post(
        "/api/internetpackages/get-all",
        data: jsonEncode(body),
      );

      if (response.statusCode == 200 && response.data != null) {
        if (response.data is Map<String, dynamic>) {
          final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
          if (responseData['data'] is List) {
            final List<dynamic> data = responseData['data'] as List<dynamic>;
            return data.map((json) => InternetPackage.fromJson(json as Map<String, dynamic>)).toList();
          }
        } else if (response.data is List) {
          final List<dynamic> data = response.data as List<dynamic>;
          return data.map((json) => InternetPackage.fromJson(json as Map<String, dynamic>)).toList();
        }
        return [];
      } else {
        throw AppException('خطا در دریافت بسته‌های اینترنت');
      }
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error!;
      throw AppException(e.message ?? 'خطایی در ارتباط با سرور رخ داده است.');
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('خطای غیرمنتظره: $e');
    }
  }

  /// خرید بسته اینترنت
  Future<InternetPackageModel> buyInternetPackage({
    required String sourceMobileNumber,
    required String walletAddress,
    required int productCode,
    required String destMobileNumber,
  }) async {
    final body = {
      "sourceMobileNumber": sourceMobileNumber,
      "walletAddress": walletAddress,
      "productCode": productCode,
      "destMobileNumber": destMobileNumber,
    };

    try {
      final response = await _dio.post(
        "/api/internetpackages/buy",
        data: jsonEncode(body),
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        if (data is String) return InternetPackageModel.successWithData(data);
        if (data is Map<String, dynamic>) {
          if (data['success'] == true) {
            return InternetPackageModel.successWithData(data['data']?.toString() ?? '');
          }
          throw AppException(data['error']?['errorMessage'] ?? 'خطا در خرید بسته اینترنت');
        }
        throw AppException('پاسخ نامعتبر از سرور');
      } else {
        throw AppException('خطا در ارتباط با سرور');
      }
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error!;
      throw AppException(e.message ?? 'خطایی در ارتباط با سرور رخ داده است.');
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('خطای غیرمنتظره: $e');
    }
  }
}