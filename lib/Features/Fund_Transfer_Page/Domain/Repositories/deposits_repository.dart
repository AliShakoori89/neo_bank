import '../Entities/deposit_entity.dart';

abstract class DepositsRepository {
  Future<List<DepositEntity>> getUserAllAccount();
}
