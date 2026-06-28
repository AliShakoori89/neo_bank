import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Data/Model/send_video_model.dart';

import '../../../../Core/Const/api_key.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';

class SendVideoRepository {
  final Dio dio;

  SendVideoRepository({Dio? dio}) : dio = dio ?? Dio();

  Future<SendVideoModel> sendVideoResponse(String randomText, String fileName, String content) async {
    final token = await LocalStorage.read('access_token');

    if (token == null || token.isEmpty) {
      throw Exception('Token not found');
    }

    print('fileName');
    print(fileName);
    print('content');
    print(content);

    final body = {
      "randomText": randomText,
      "fileData": {
        "fileName": fileName,
        "content": content
      },
    };

    final json = jsonEncode(body);

    print(json.length);

    try {
      final response = await dio.post(
        "${APIKey.baseUrl}/api/kycs/send-video",
        data: jsonEncode(body),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": token,
          },
        ),
      );

      print('response.statusCode');
      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['success'] == true) {
          return SendVideoModel.fromJson(data);
        }
        throw Exception(
          data['error']?['errorMessage'] ?? 'Unknown error',
        );
      }

      throw Exception('خطا در ارتباط با سرور');
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ?? e.message;
      throw Exception(message);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}