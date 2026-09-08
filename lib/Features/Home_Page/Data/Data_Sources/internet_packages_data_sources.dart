import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../Core/Network/dio_client.dart';
import '../Model/internet_package_model.dart';

@lazySingleton
class InternetPackagesDataSources {
  final Dio _dio;

  InternetPackagesDataSources({
    required DioClient dioClient,
  }) : _dio = dioClient.dio;

  Future<List<InternetPackage>> getAllInternetPackages(int operatorCode) async {

    final body = {
      "operatorCode": operatorCode,
    };

    final response = await _dio.post(
      "/api/internetpackages/get-all",
      data: body,
    );

    if (response.data is Map<String, dynamic>) {
      final responseData = response.data as Map<String, dynamic>;

      if (responseData['data'] is List) {
        final data = responseData['data'] as List;

        return data
            .map(
              (json) => InternetPackage.fromJson(
            json as Map<String, dynamic>,
          ),
        ).toList();
      }
    }

    if (response.data is List) {
      final data = response.data as List;

      return data
          .map(
            (json) => InternetPackage.fromJson(
          json as Map<String, dynamic>,
        ),
      )
          .toList();
    }

    return [];
  }

  /// دریافت بسته‌های اینترنت با فیلتر
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

    final response = await _dio.post(
      "/api/internetpackages/get-all",
      data: body,
    );

    if (response.data is Map<String, dynamic>) {
      final responseData = response.data as Map<String, dynamic>;

      if (responseData['data'] is List) {
        final data = responseData['data'] as List;

        return data
            .map(
              (json) => InternetPackage.fromJson(
            json as Map<String, dynamic>,
          ),
        ).toList();
      }
    }

    if (response.data is List) {
      final data = response.data as List;

      return data
          .map(
            (json) => InternetPackage.fromJson(
          json as Map<String, dynamic>,
        ),
      ).toList();
    }

    return [];
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

    final response = await _dio.post(
      "/api/internetpackages/buy",
      data: body,
    );

    final data = response.data;

    if (data is String) {
      return InternetPackageModel.successWithData(data);
    }

    if (data is Map<String, dynamic>) {
      if (data['success'] == true) {
        return InternetPackageModel.successWithData(
          data['data']?.toString() ?? '',
        );
      }
    }

    throw Exception('پاسخ نامعتبر از سرور');
  }
}