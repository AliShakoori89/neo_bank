import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Data/Models/deposits_model.dart';
import '../../../../Core/Const/app_exception.dart';

class DepositsRepository {
  final Dio dio;

  DepositsRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  Future<DepositsModel> getUserAllAccount() async {
    try {
      final response = await dio.post("/api/deposits/get-all");

      if (response.statusCode == 200) {
        return DepositsModel.fromJson(response.data);
      } else {
        throw AppException('Failed to fetch deposits');
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
