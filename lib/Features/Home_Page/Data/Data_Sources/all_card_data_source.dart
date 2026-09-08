import 'package:dio/dio.dart';

import '../Model/card_list_model.dart';

class AllCardDataSource {
  final Dio dio;

  AllCardDataSource({required this.dio});

  Future<CardListModel> getAllCards() async{

    final response = await dio.post("/api/cards/get-all");

    return CardListModel.fromJson(response.data);
  }
}