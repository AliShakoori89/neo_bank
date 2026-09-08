import '../../Domain/Entities/loan_entity.dart';
import '../../Domain/Repositories/loan_page_repository.dart';
import '../Data_Sources/loan_page_data_source.dart';

class LoanPageRepositoryImpl implements LoanPageRepository{

  final LoanPageDataSource loanPageDataSource;

  LoanPageRepositoryImpl({required this.loanPageDataSource});

  @override
  Future<List<LoanEntity>> getLoans({
    required String nationalNumber,
  }) async {

    final data = await loanPageDataSource.getLoans(
      nationalNumber: nationalNumber,
    );

    return data;
  }
}