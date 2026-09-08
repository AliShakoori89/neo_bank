import 'package:injectable/injectable.dart';
import '../Entities/deposit_entity.dart';
import '../Repositories/deposits_repository.dart';

@lazySingleton
class DepositUseCase {
  final DepositsRepository repository;

  DepositUseCase({required this.repository});

  Future<List<DepositEntity>> getUserAllAccount(){
    return repository.getUserAllAccount();
  }
}