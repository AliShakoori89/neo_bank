import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Data/DataSources/all_card_detail_remote_data_source.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Domain/Repositories/all_card_detail_repository.dart';
import '../../../../Core/Network/app_exception.dart';

class AllCardDetailRepositoryImpl implements AllCardDetailRepository{

  AllCardDetailRemoteDataSource allCardDetailRemoteDataSource;

  AllCardDetailRepositoryImpl({required this.allCardDetailRemoteDataSource});

  @override
  Future<List<String>> getAllCardsPan() async {
    try {

      final data = await allCardDetailRemoteDataSource.getAllCardsPan();

      if (data.success == true) {

        final cards = data;
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
      if (e.response?.statusCode == 401) {
        throw AppException(
          'نشست شما منقضی شده است.',
          statusCode: 401,
        );
      }
      if (e.error is AppException) {
        throw e.error!;
      }
      throw AppException(e.message ?? 'خطایی در ارتباط با سرور رخ داده است.');
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('خطای غیرمنتظره: $e');
    }

  }

  @override
  Future<List<String>> getAllCardsDeposit() async {
    try {

      final data = await allCardDetailRemoteDataSource.getAllCardsPan();

      if (data.success == true) {
        final cards = data;
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