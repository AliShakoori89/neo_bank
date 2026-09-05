import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Data/Models/all_cards_pans_model.dart';
import '../../../../Core/Network/app_exception.dart';

class AllCardDetailRepository {
  final Dio dio;

  AllCardDetailRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  Future<List<String>> getAllCardsPan() async {
    try {
      final response = await dio.post("/api/cards/get-all");

      if (response.statusCode == 200) {
        final cards = AllCardsPansModel.fromJson(response.data);
        final List<String> cardsPan = [];

        if (cards.data != null) {
          for (final card in cards.data!) {
            if (card.pan != null) cardsPan.add(card.pan!);
          }
        }
        return cardsPan;
      } else {
        throw AppException('Failed to fetch cards');
      }
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

  Future<List<String>> getAllCardsDeposit() async {
    try {
      final response = await dio.post("/api/cards/get-all");

      if (response.statusCode == 200) {
        final cards = AllCardsPansModel.fromJson(response.data);
        final List<String> cardsDeposit = [];

        if (cards.data != null) {
          for (final card in cards.data!) {
            if (card.depositNumber != null) {
              cardsDeposit.add(card.depositNumber!);
            }
          }
        }
        return cardsDeposit;
      } else {
        throw AppException('Failed to fetch cards');
      }
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
