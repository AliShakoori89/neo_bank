import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../Core/Const/api_key.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';
import '../../Data/Model/internet_package_model.dart';

class InternetPackagesRepository {

  final dio = Dio();

  Future<List<InternetPackageModel>> getAllInternetPackages(int operatorCode) async{

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

  Future<List<InternetPackageModel>> getInternetPackages(int operatorCode, int packageTimeCode, int simType, String traffic) async {
    final token = await LocalStorage.read('access_token');
    if (token == null) throw Exception('Token not found');

    final body = {
      "operatorCode": operatorCode,
      "packageTimeCode": packageTimeCode,
      "simType": simType,
      "traffic": "traffic"
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

        // تبدیل لیست JSON به لیست مدل‌ها
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
}