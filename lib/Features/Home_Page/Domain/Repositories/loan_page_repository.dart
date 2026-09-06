import '../../Data/Model/loan_model.dart';

abstract class LoanPageRepository {
  Future<List<LoanModel>> getLoans({
    required String nationalNumber,
  });
}