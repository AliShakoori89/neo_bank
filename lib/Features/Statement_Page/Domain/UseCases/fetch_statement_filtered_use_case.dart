import '../../Data/Model/statement_model.dart';
import '../Repositories/statement_repository.dart';

class FetchStatementFilteredUseCase {
  final StatementRepository repository;

  FetchStatementFilteredUseCase({required this.repository});

  Future<StatementResponseModel> getFilteredStatement({
    required String depositNumber,
    required int offset,
    int? statementActionType,
    required String startDate,
    required String endDate,
  }){
    return repository.getLastestStatement(depositNumber: depositNumber, offset: offset);
  }
}