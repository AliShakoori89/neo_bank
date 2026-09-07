import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Domain/Entities/deposit_entity.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Domain/Repositories/deposits_repository.dart';

class DepositUseCase {
  final DepositsRepository repository;

  DepositUseCase({required this.repository});

  Future<List<DepositEntity>> getUserAllAccount(){
    return repository.getUserAllAccount();
  }
}