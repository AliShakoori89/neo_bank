import 'dart:async';
import '../../../Statement_Page/Data/Model/statement_model.dart';

abstract class LastTransactionRepository {

  Future<StatementResponseModel> getLastestStatement(String depositNumber);

}