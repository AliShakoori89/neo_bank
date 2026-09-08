import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Domain/UseCases/loan_page_use_case.dart';
import 'loan_page_event.dart';
import 'loan_page_state.dart';

class LoanPageBloc
    extends Bloc<LoanPageEvent, LoanPageState> {
  final LoanPageUseCase loanPageUseCase;

  LoanPageBloc({required this.loanPageUseCase})
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

      final result = await loanPageUseCase.getLoans(nationalNumber: '2680122593');

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