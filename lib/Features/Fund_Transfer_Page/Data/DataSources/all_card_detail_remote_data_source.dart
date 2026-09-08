import 'package:dio/dio.dart';
import '../Models/all_card_pan_model.dart';

class AllCardDetailRemoteDataSource {
  final Dio dio;

  AllCardDetailRemoteDataSource({required this.dio});

  Future<AllCardPanModel> getAllCardsPan() async{

    final response = await dio.post("/api/cards/get-all");

    return AllCardPanModel.fromJson(response.data);
  }
}