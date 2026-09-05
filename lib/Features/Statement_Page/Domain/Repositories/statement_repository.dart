import 'dart:async';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Data/Model/statement_model.dart';

abstract class StatementRepository {
  Future<StatementResponseModel> getLastestStatement({
    required String depositNumber,
    required int offset,
  });

  Future<StatementResponseModel> getFilterStatement({
    required String depositNumber,
    required int offset,
    int? statementActionType,
    required String startDate,
    required String endDate,
  });
}