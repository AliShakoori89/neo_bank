import 'package:dio/dio.dart';
import '../../../../Core/Network/app_exception.dart';
import 'package:injectable/injectable.dart';

import '../../Domain/Entities/card_list_entity.dart';
import '../../Domain/Repositories/all_card_repository.dart';
import '../Data_Sources/all_card_data_source.dart';


@LazySingleton(as: AllCardRepository)
class AllCardRepositoryImpl implements AllCardRepository{

  final AllCardDataSource allCardDataSources;

  AllCardRepositoryImpl({required this.allCardDataSources});

  @override
  Future<List<CardEntity>> getAllCards() async {

    try {

      final data = await allCardDataSources.getAllCards();

      if (data.success == true && data.data != null) {
        return data.data!
            .map((card) => card.toEntity())
            .toList();
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