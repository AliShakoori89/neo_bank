import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Wallet_Page/Data/Model/wallet_model.dart';
import '../../../../../../../Core/Const/api_key.dart';
import '../../../../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';

class InternetPackagesRepository {

  final dio = Dio();

  Future<List<WalletModel>> getWalletDetails() async{

    final token = await LocalStorage.read('access_token');
    if (token == null) throw Exception('Token not found');

    try {
      final response = await dio.post(
        "${APIKey.baseUrl}/api/wallets/get-all",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': token,
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        List<WalletModel> packages = data
            .map((json) => WalletModel.fromJson(json))
            .toList();

        return packages;
      } else {
        throw Exception('خطا در دریافت اطلاعات کیف پول: ${response.statusCode}');
      }
    } catch (e) {
      print('خطا در دریافت اطلاعات کیف پول: $e');
      rethrow;
    }
  }

}