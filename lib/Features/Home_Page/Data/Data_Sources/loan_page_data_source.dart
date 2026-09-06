import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../Model/loan_model.dart';

class LoanPageDataSource {
  final Dio dio;

  LoanPageDataSource({
    required this.dio,
  });

  Future<List<LoanModel>> getLoans({
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
          .map((item) => LoanModel.fromJson(item))
          .toList();
    }

    throw Exception(
      'خطا در دریافت لیست وام‌ها: ${response.statusCode}',
    );
  }
}