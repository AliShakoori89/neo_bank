import '../../Data/Model/statement_model.dart';
import '../Repositories/statement_repository.dart';

class FetchStatementUseCase {
  final StatementRepository repository;

  FetchStatementUseCase({required this.repository});

  Future<StatementResponseModel> getLastestStatement({
    required String depositNumber,
    required int offset,
  }){
    return repository.getLastestStatement(depositNumber: depositNumber, offset: offset);
  }
}