import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Data/Models/deposits_model.dart';

abstract class DepositsRepository {
  Future<DepositsModel> getUserAllAccount();
}
