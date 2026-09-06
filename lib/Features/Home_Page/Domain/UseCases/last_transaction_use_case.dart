import '../../../Statement_Page/Data/Model/statement_model.dart';
import '../Repositories/last_transaction_repository.dart';

class LastTransactionUseCase {
  final LastTransactionRepository lastTransactionRepository;

  LastTransactionUseCase({required this.lastTransactionRepository});

  Future<StatementResponseModel> getLastestStatement(String depositNumber){
    return lastTransactionRepository.getLastestStatement(depositNumber);
  }
}