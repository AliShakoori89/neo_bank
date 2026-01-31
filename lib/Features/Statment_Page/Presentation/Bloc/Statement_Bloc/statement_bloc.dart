import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Domain/Repository/statement_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Presentation/Bloc/Statement_Bloc/statement_event.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Presentation/Bloc/Statement_Bloc/statement_state.dart';

class StatementBloc extends Bloc<StatementEvent, StatementState> {
  StatementRepository statementRepository;

  StatementBloc(this.statementRepository) : super(StatementState.initial()) {
    on<GetLastestStatmentEvent>(_mapUserLoginEventToState);
  }

  void _mapUserLoginEventToState(
    GetLastestStatmentEvent event,
    Emitter<StatementState> emit,
  ) async {
    try {
      emit(state.copyWith(status: StatementStateStatus.loading));

      final result = await statementRepository.getLastestStatement(
        event.depositNumber,
      );

      emit(
        state.copyWith(
          status: StatementStateStatus.error,
          topStatement: result.data,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: StatementStateStatus.error));
    }
  }
}
