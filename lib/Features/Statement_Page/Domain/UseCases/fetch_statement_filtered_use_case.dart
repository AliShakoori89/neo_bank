import '../Entities/statement_entity.dart';
import '../Repositories/statement_repository.dart';

class FetchStatementFilteredUseCase {
  final StatementRepository repository;

  FetchStatementFilteredUseCase({required this.repository});

  Future<StatementEntity> getFilteredStatement({
    required String depositNumber,
    required int offset,
    int? statementActionType,
    required String startDate,
    required String endDate,
  }) {
    return repository.getFilterStatement(
      depositNumber: depositNumber,
      offset: offset,
      statementActionType: statementActionType,
      startDate: startDate,
      endDate: endDate,
    );
  }
}