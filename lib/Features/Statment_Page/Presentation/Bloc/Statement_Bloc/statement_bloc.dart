import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Data/Model/statement_model.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Domain/Repository/statement_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Presentation/Bloc/Statement_Bloc/statement_event.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Presentation/Bloc/Statement_Bloc/statement_state.dart';

class StatementBloc extends Bloc<StatementEvent, StatementState> {
  final StatementRepository statementRepository;

  StatementBloc(this.statementRepository) : super(StatementState.initial()) {
    on<FetchStatementEvent>(_onFetchStatement);
  }

  Future<void> _onFetchStatement(
    FetchStatementEvent event,
    Emitter<StatementState> emit,
  ) async {
    try {
      // ⛔️ loading فقط وقتی دیتا نداری
      if (state.topStatement.isEmpty) {
        emit(state.copyWith(status: StatementStateStatus.loading));
      }

      final result = await statementRepository.getLastestStatement(
        event.depositNumber,
      );

      final allList = List<StatementDataModel>.from(result.data ?? [])
        ..sort((a, b) => b.date!.compareTo(a.date!));

      final topList = event.latestCount == null
          ? allList
          : allList.take(event.latestCount!).toList();

      emit(
        state.copyWith(
          status: StatementStateStatus.success,
          allStatement: allList,
          topStatement: topList,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: StatementStateStatus.error));
    }
  }
}
