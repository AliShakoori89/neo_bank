import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/card_list_model.dart';
import '../../../../Core/Network/app_exception.dart';

class AllCardRepository {
  final Dio dio;

  AllCardRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  Future<CardListModel> getAllCards() async {
    try {
      final response = await dio.post("/api/cards/get-all");

      if (response.statusCode == 200) {
        return CardListModel.fromJson(response.data);
      }
      throw AppException('Failed to fetch cards');
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error!;
      }
      throw AppException(e.message ?? 'خطایی در ارتباط با سرور رخ داده است.');
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('خطای غیرمنتظره: $e');
    }
  }
}
