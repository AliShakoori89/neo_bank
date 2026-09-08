import 'dart:convert';
import 'package:dio/dio.dart';

import '../../../../Core/Network/app_exception.dart';
import '../../../../Core/Network/dio_client.dart';
import '../../Data/Model/send_video_model.dart';

class SendVideoRepository {
  final Dio dio;

  SendVideoRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  Future<SendVideoModel> sendVideoResponse(String randomText, String fileName, String content) async {

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

    try {
      final response = await dio.post(
        "/api/kycs/send-video",
        data: jsonEncode(body),
      );

      final data = response.data;

      if (data['success'] == true) {
        return SendVideoModel.fromJson(data);
      }

      print('response.statusCode');
      print(response.statusCode);
      print(response.data);
      
      throw AppException(
        data['error']?['errorMessage'] ?? 'عملیات با خطا مواجه شد.',
      );
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
