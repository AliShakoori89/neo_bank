import '../../Data/Model/loan_model.dart';
import '../Repositories/loan_page_repository.dart';

class LoanPageUseCase {
  final LoanPageRepository loanPageRepository;

  LoanPageUseCase({required this.loanPageRepository});

  Future<List<LoanModel>> getLoans({
    required String nationalNumber,
  }){
    return loanPageRepository.getLoans(nationalNumber: nationalNumber);
  }
}