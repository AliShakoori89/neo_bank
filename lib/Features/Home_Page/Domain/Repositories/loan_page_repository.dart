import '../Entities/loan_entity.dart';

abstract class LoanPageRepository {
  Future<List<LoanEntity>> getLoans({
    required String nationalNumber,
  });
}