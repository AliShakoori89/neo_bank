import 'package:injectable/injectable.dart';
import '../Entities/loan_entity.dart';
import '../Repositories/loan_page_repository.dart';

@lazySingleton
class LoanPageUseCase {
  final LoanPageRepository loanPageRepository;

  LoanPageUseCase({required this.loanPageRepository});

  Future<List<LoanEntity>> getLoans({
    required String nationalNumber,
  }){
    return loanPageRepository.getLoans(nationalNumber: nationalNumber);
  }
}