import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../Core/Network/dio_client.dart';
import '../Models/all_card_pan_model.dart';

@lazySingleton
class AllCardDetailRemoteDataSource {
  final Dio _dio;

  AllCardDetailRemoteDataSource({
    required DioClient dioClient,
  }) : _dio = dioClient.dio;

  Future<AllCardPanModel> getAllCardsPan() async{

    final response = await _dio.post("/api/cards/get-all");

    return AllCardPanModel.fromJson(response.data);
  }
}