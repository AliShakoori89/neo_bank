import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Data_Sources/all_card_data_source.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Repositories/all_card_repository.dart';
import '../../../../Core/Network/app_exception.dart';
import '../Model/card_list_model.dart';

class AllCardRepositoryImpl implements AllCardRepository{

  final AllCardDataSource allCardDataSources;

  AllCardRepositoryImpl({required this.allCardDataSources});

  @override
  Future<CardListModel> getAllCards() async {

    final data = await allCardDataSources.getAllCards();
  try {
    if (data.success == true) {
      return data;
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