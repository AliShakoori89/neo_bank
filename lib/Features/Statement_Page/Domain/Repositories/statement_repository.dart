import 'dart:async';
import '../Entities/statement_entity.dart';

abstract class StatementRepository {
  Future<StatementEntity> getLastestStatement({
    required String depositNumber,
    required int offset,
  });

  Future<StatementEntity> getFilterStatement({
    required String depositNumber,
    required int offset,
    int? statementActionType,
    required String startDate,
    required String endDate,
  });
}