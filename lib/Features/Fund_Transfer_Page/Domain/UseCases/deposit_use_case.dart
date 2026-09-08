import '../Entities/deposit_entity.dart';
import '../Repositories/deposits_repository.dart';

class DepositUseCase {
  final DepositsRepository repository;

  DepositUseCase({required this.repository});

  Future<List<DepositEntity>> getUserAllAccount(){
    return repository.getUserAllAccount();
  }
}