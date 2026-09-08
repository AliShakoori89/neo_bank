import 'package:injectable/injectable.dart';
import '../Entities/statement_entity.dart';
import '../Repositories/statement_repository.dart';

@lazySingleton
class FetchStatementUseCase {
  final StatementRepository repository;

  FetchStatementUseCase({required this.repository});

  Future<StatementEntity> getLastestStatement({
    required String depositNumber,
    required int offset,
  }){
    return repository.getLastestStatement(depositNumber: depositNumber, offset: offset);
  }
}