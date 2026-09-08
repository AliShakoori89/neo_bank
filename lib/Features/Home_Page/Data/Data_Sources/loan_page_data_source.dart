import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import '../../../../Core/Network/dio_client.dart';
import '../../Domain/Entities/loan_entity.dart';

@lazySingleton
class LoanPageDataSource {
  final Dio _dio;

  LoanPageDataSource({
    required DioClient dioClient,
  }) : _dio = dioClient.dio;

  Future<List<LoanEntity>> getLoans({
    required String nationalNumber,
  }) async {

    final url = Uri.parse(
      'http://10.180.7.11:7055/api/Customers/$nationalNumber/loans',
    );

    final response = await http.get(url);

    print('STATUS CODE: ${response.statusCode}');
    print('RESPONSE: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map((item) => LoanEntity.fromJson(item))
          .toList();
    }

    throw Exception(
      'خطا در دریافت لیست وام‌ها: ${response.statusCode}',
    );
  }
}