import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Data_Sources/loan_page_data_source.dart';
import '../../Domain/Repositories/loan_page_repository.dart';
import '../Model/loan_model.dart';

class LoanPageRepositoryImpl implements LoanPageRepository{

  final LoanPageDataSource loanPageDataSource;

  LoanPageRepositoryImpl({required this.loanPageDataSource});

  @override
  Future<List<LoanModel>> getLoans({
    required String nationalNumber,
  }) async {

    final data = await loanPageDataSource.getLoans(
      nationalNumber: nationalNumber,
    );

    return data;
  }
}