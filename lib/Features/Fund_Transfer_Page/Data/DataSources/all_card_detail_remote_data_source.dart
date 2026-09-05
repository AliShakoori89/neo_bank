import 'package:dio/dio.dart';
import '../Models/all_cards_pans_model.dart';

class AllCardDetailRemoteDataSource {
  final Dio dio;

  AllCardDetailRemoteDataSource({required this.dio});

  Future<AllCardsPansModel> getAllCardsPan() async{

    final response = await dio.post("/api/cards/get-all");

    return AllCardsPansModel.fromJson(response.data);
  }
}