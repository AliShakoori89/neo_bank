import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Domain/Repositories/deposits_repository.dart';
import '../../Data/Models/deposits_model.dart';

class DepositUseCase {
  final DepositsRepository repository;

  DepositUseCase({required this.repository});

  Future<DepositsModel> getUserAllAccount(){
    return repository.getUserAllAccount();
  }
}