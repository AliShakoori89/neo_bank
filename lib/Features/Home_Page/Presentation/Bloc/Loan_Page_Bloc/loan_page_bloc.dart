import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Loan_Page_Bloc/loan_page_event.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Loan_Page_Bloc/loan_page_state.dart';
import '../../../Domain/Repository/loan_page_repository.dart';

class LoanPageBloc
    extends Bloc<LoanPageEvent, LoanPageState> {
  final LoanPageRepository loanPageRepository;

  LoanPageBloc(this.loanPageRepository)
      : super(LoanPageState.initial()) {
    on<AllLoanPageListEvent>(_onAllLoanPageListEventToState);
  }

  Future<void> _onAllLoanPageListEventToState(
      AllLoanPageListEvent event,
      Emitter<LoanPageState> emit,
      ) async {
    try {
      // // ⛔️ loading فقط وقتی دیتا نداری
      // if (state.loan.data!.isEmpty) {
      //   emit(state.copyWith(status: LoanPageStateStatus.loading));
      // }

      final result = await loanPageRepository.getLoans(nationalNumber: '2680122593');

      emit(
        state.copyWith(
          status: LoanPageStateStatus.success,
          loan: result,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: LoanPageStateStatus.error));
    }
  }
}