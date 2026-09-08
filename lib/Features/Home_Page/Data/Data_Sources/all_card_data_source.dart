import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../Core/Network/dio_client.dart';
import '../Model/card_list_model.dart';

@lazySingleton
class AllCardDataSource {
  final Dio _dio;

  AllCardDataSource({
    required DioClient dioClient,
  }) : _dio = dioClient.dio;

  Future<CardListModel> getAllCards() async{

    final response = await _dio.post("/api/cards/get-all");

    return CardListModel.fromJson(response.data);
  }
}