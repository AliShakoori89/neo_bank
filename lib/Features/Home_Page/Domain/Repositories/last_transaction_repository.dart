import 'dart:async';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Data/Model/statement_model.dart';

abstract class LastTransactionRepository {

  Future<StatementResponseModel> getLastestStatement(String depositNumber);

}