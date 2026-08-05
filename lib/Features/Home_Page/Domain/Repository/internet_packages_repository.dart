import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../Core/Const/api_key.dart';
import '../../../../Core/Const/app_exception.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';
import '../../Data/Model/buy_internet_model.dart';
import '../../Data/Model/internet_package_model.dart';

class InternetPackagesRepository {
  final Dio _dio;

  InternetPackagesRepository({
    Dio? dio,
  }) : _dio = dio ?? Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

  /// دریافت همه بسته‌های اینترنت بر اساس کد اپراتور
  /// پاسخ سرور: { "data": [...], "success": true, "traceId": "..." }
  Future<List<InternetPackage>> getAllInternetPackages(int operatorCode) async {
    final token = await LocalStorage.read('access_token');

    if (token == null || token.isEmpty) {
      throw AppException('توکن یافت نشد. لطفاً دوباره وارد شوید.');
    }

    final body = {
      "operatorCode": operatorCode,
    };

    try {
      final response = await _dio.post(
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

      print('📦 وضعیت پاسخ: ${response.statusCode}');
      print('📦 نوع داده: ${response.data.runtimeType}');

      if (response.statusCode == 200 && response.data != null) {
        // پاسخ به صورت Map است (با کلید data)
        if (response.data is Map<String, dynamic>) {
          final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;

          // بررسی موفقیت
          if (responseData.containsKey('success') && responseData['success'] == false) {
            final errorMessage = responseData['error']?['errorMessage'] as String? ??
                responseData['message'] as String? ??
                'خطا در دریافت بسته‌ها';
            throw AppException(errorMessage);
          }

          // استخراج داده از کلید 'data'
          if (responseData.containsKey('data') && responseData['data'] is List) {
            final List<dynamic> data = responseData['data'] as List<dynamic>;
            print('📦 تعداد بسته‌های دریافت شده: ${data.length}');

            if (data.isEmpty) {
              print('⚠️ هیچ بسته‌ای یافت نشد');
              return [];
            }

            final List<InternetPackage> packages = data
                .map((json) => InternetPackage.fromJson(json as Map<String, dynamic>))
                .toList();

            print('✅ تعداد بسته‌های تبدیل شده: ${packages.length}');
            return packages;
          } else {
            print('⚠️ کلید data در پاسخ وجود ندارد');
            return [];
          }
        }
        // اگر پاسخ مستقیماً List بود (برای برخی APIها)
        else if (response.data is List) {
          final List<dynamic> data = response.data as List<dynamic>;
          print('📦 تعداد بسته‌های دریافت شده: ${data.length}');

          final List<InternetPackage> packages = data
              .map((json) => InternetPackage.fromJson(json as Map<String, dynamic>))
              .toList();

          return packages;
        }

        return [];
      } else {
        throw AppException('خطا در دریافت بسته‌های اینترنت: کد خطا ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Dio Error در دریافت بسته‌ها: ${e.message}');
      throw AppException(_handleDioError(e));
    } catch (e) {
      print('❌ خطا در دریافت بسته‌های اینترنت: $e');
      rethrow;
    }
  }

  /// دریافت بسته‌های اینترنت با فیلترهای مختلف
  Future<List<InternetPackage>> getInternetPackages({
    required int operatorCode,
    required int packageTimeCode,
    required int simType,
    required String traffic,
  }) async {
    final token = await LocalStorage.read('access_token');
    if (token == null || token.isEmpty) {
      throw AppException('توکن یافت نشد. لطفاً دوباره وارد شوید.');
    }

    final body = {
      "operatorCode": operatorCode,
      "packageTimeCode": packageTimeCode,
      "simType": simType,
      "traffic": traffic,
    };

    try {
      final response = await _dio.post(
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

      print('📦 وضعیت پاسخ (فیلتر شده): ${response.statusCode}');
      print('📦 نوع داده: ${response.data.runtimeType}');

      if (response.statusCode == 200 && response.data != null) {
        // پاسخ به صورت Map است (با کلید data)
        if (response.data is Map<String, dynamic>) {
          final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;

          if (responseData.containsKey('data') && responseData['data'] is List) {
            final List<dynamic> data = responseData['data'] as List<dynamic>;
            print('📦 تعداد بسته‌های فیلتر شده: ${data.length}');

            final List<InternetPackage> packages = data
                .map((json) => InternetPackage.fromJson(json as Map<String, dynamic>))
                .toList();
            return packages;
          }
        }
        // اگر پاسخ مستقیماً List بود
        else if (response.data is List) {
          final List<dynamic> data = response.data as List<dynamic>;
          print('📦 تعداد بسته‌های فیلتر شده: ${data.length}');

          final List<InternetPackage> packages = data
              .map((json) => InternetPackage.fromJson(json as Map<String, dynamic>))
              .toList();
          return packages;
        }

        return [];
      } else {
        throw AppException('خطا در دریافت بسته‌های اینترنت: کد خطا ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Dio Error: ${e.message}');
      throw AppException(_handleDioError(e));
    } catch (e) {
      print('❌ خطا در دریافت بسته‌های اینترنت: $e');
      rethrow;
    }
  }

  /// دریافت بسته‌های اینترنت با پاسخ کامل (برای زمانی که نیاز به success و traceId دارید)
  Future<InternetPackageModel> getAllInternetPackagesWithResponse(int operatorCode) async {
    final token = await LocalStorage.read('access_token');

    if (token == null || token.isEmpty) {
      return InternetPackageModel.error('توکن یافت نشد. لطفاً دوباره وارد شوید.');
    }

    final body = {
      "operatorCode": operatorCode,
    };

    try {
      final response = await _dio.post(
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

      if (response.statusCode == 200 && response.data != null) {
        // پاسخ به صورت Map است
        if (response.data is Map<String, dynamic>) {
          final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;

          // استخراج داده از کلید 'data'
          List<InternetPackage> packages = [];
          if (responseData.containsKey('data') && responseData['data'] is List) {
            final List<dynamic> data = responseData['data'] as List<dynamic>;
            packages = data
                .map((json) => InternetPackage.fromJson(json as Map<String, dynamic>))
                .toList();
          }

          final bool success = responseData['success'] as bool? ?? true;
          final String traceId = responseData['traceId'] as String? ?? '';

          if (success) {
            return InternetPackageModel(
              data: packages,
              success: true,
              traceId: traceId,
              error: null,
            );
          } else {
            return InternetPackageModel(
              data: [],
              success: false,
              traceId: traceId,
              error: responseData['error'],
            );
          }
        }
        // اگر پاسخ مستقیماً List بود
        else if (response.data is List) {
          final List<dynamic> data = response.data as List<dynamic>;
          final List<InternetPackage> packages = data
              .map((json) => InternetPackage.fromJson(json as Map<String, dynamic>))
              .toList();

          return InternetPackageModel(
            data: packages,
            success: true,
            traceId: '',
            error: null,
          );
        }
      }

      return InternetPackageModel.error('خطا در دریافت اطلاعات');
    } on DioException catch (e) {
      print('❌ Dio Error: ${e.message}');
      return InternetPackageModel.error(_handleDioError(e));
    } catch (e) {
      print('❌ خطا: $e');
      return InternetPackageModel.error(e.toString());
    }
  }

  /// خرید بسته اینترنت
  Future<InternetPackageModel> buyInternetPackage({
    required String sourceMobileNumber,
    required String walletAddress,
    required int productCode,
    required String destMobileNumber,
  }) async {
    final token = await LocalStorage.read('access_token');
    if (token == null || token.isEmpty) {
      return InternetPackageModel.error('توکن یافت نشد. لطفاً دوباره وارد شوید.');
    }

    if (sourceMobileNumber.isEmpty || walletAddress.isEmpty || destMobileNumber.isEmpty) {
      return InternetPackageModel.error('اطلاعات وارد شده معتبر نیست');
    }

    if (productCode <= 0) {
      return InternetPackageModel.error('کد محصول معتبر نیست');
    }

    final body = {
      "sourceMobileNumber": sourceMobileNumber,
      "walletAddress": walletAddress,
      "productCode": productCode,
      "destMobileNumber": destMobileNumber,
    };

    try {
      print('🚀 شروع خرید بسته اینترنت...');
      print('📦 Body: $body');

      final response = await _dio.post(
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

      print('✅ پاسخ دریافت شد با وضعیت: ${response.statusCode}');

      if (response.statusCode == 200 && response.data != null) {
        return _parseBuyResponse(response.data);
      } else {
        return InternetPackageModel.error('خطا در ارتباط با سرور: کد خطا ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Dio Error در خرید: ${e.message}');
      return _handleBuyDioError(e);
    } catch (e) {
      print('❌ خطا در خرید بسته اینترنت: $e');
      return InternetPackageModel.error('خطای ناشناخته رخ داده است');
    }
  }

  // تبدیل ترافیک به فرمت خوانا
  String formatTraffic(String traffic) {
    if (traffic.isEmpty) return '0 مگابایت';

    final int trafficValue = int.tryParse(traffic) ?? 0;

    if (trafficValue >= 1024) {
      final double gb = trafficValue / 1024;
      return '${gb.toStringAsFixed(gb.truncateToDouble() == gb ? 0 : 1)} گیگابایت';
    }
    return '$trafficValue مگابایت';
  }

  // فرمت قیمت
  String formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    );
  }

  InternetPackageModel _parseBuyResponse(dynamic data) {
    if (data is String) {
      return InternetPackageModel.successWithData(data);
    }

    if (data is Map<String, dynamic>) {
      if (data['success'] == true) {
        if (data['data'] is String) {
          return InternetPackageModel.successWithData(data['data'] as String);
        }
        if (data['data'] is Map<String, dynamic>) {
          return InternetPackageModel.successWithData(jsonEncode(data['data']));
        }
        return InternetPackageModel.success();
      }

      if (data.containsKey('error') && data['error'] is Map<String, dynamic>) {
        try {
          final errorModel = BuyInternetModel.fromJson(data);
          return InternetPackageModel.failure(errorModel);
        } catch (_) {
          final errorMessage = data['error']?['errorMessage'] as String? ?? 'خطا در انجام تراکنش';
          return InternetPackageModel.error(errorMessage);
        }
      }

      final errorMessage = data['message'] as String? ??
          data['errorMessage'] as String? ??
          'خطا در انجام تراکنش';
      return InternetPackageModel.error(errorMessage);
    }

    return InternetPackageModel.error('پاسخ نامعتبر از سرور');
  }

  InternetPackageModel _handleBuyDioError(DioException e) {
    if (e.response?.data != null) {
      try {
        final responseData = e.response!.data;
        if (responseData is Map<String, dynamic>) {
          try {
            final errorModel = BuyInternetModel.fromJson(responseData);
            if (errorModel.errorMessage.isNotEmpty) {
              return InternetPackageModel.failure(errorModel);
            }
          } catch (_) {
            final errorMessage = responseData['error']?['errorMessage'] as String? ??
                responseData['message'] as String? ??
                _getDioErrorMessage(e);
            return InternetPackageModel.error(errorMessage);
          }
        }
      } catch (_) {}
    }

    return InternetPackageModel.error(_getDioErrorMessage(e));
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'زمان ارتباط با سرور به پایان رسید';
      case DioExceptionType.receiveTimeout:
        return 'سرور پاسخ نمی‌دهد';
      case DioExceptionType.sendTimeout:
        return 'خطا در ارسال درخواست';
      case DioExceptionType.connectionError:
        return 'لطفاً اتصال اینترنت خود را بررسی کنید';
      case DioExceptionType.cancel:
        return 'درخواست لغو شد';
      default:
        if (e.response?.statusCode != null) {
          return 'خطای سرور: کد خطا ${e.response!.statusCode}';
        }
        return 'خطا در ارتباط با سرور';
    }
  }

  String _getDioErrorMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'زمان ارتباط با سرور به پایان رسید';
      case DioExceptionType.receiveTimeout:
        return 'سرور پاسخ نمی‌دهد';
      case DioExceptionType.connectionError:
        return 'لطفاً اتصال اینترنت خود را بررسی کنید';
      default:
        return 'خطا در ارتباط با سرور';
    }
  }
}