import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Data/Model/statement_model.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Domain/Repository/statement_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Presentation/Bloc/Statement_Bloc/statement_event.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Presentation/Bloc/Statement_Bloc/statement_state.dart';

class StatementBloc extends Bloc<StatementEvent, StatementState> {
  final StatementRepository statementRepository;

  StatementBloc(this.statementRepository) : super(StatementState.initial()) {
    on<FetchStatementEvent>(_onFetchStatement);
    on<LoadMoreStatementEvent>(_onLoadAllStatementMore);
    on<FetchFilterStatementEvent>(_onFetchFilterStatement);
    on<LoadMoreFilteredStatementEvent>(_onLoadFilteredStatementMore);
  }

  Future<void> _onFetchStatement(
    FetchStatementEvent event,
    Emitter<StatementState> emit,
  ) async {
    try {
      // ⛔️ loading فقط وقتی دیتا نداری
      if (state.allStatement.isEmpty) {
        emit(state.copyWith(status: StatementStateStatus.loading));
      }

      final result = await statementRepository.getLastestStatement(
        depositNumber: event.depositNumber,
        offset: 0,
      );

      final allList = List<StatementModel>.from(result.data!.statements ?? [])
        ..sort((a, b) => b.date!.compareTo(a.date!));

      emit(
        state.copyWith(
          status: StatementStateStatus.success,
          allStatement: allList,
          hasMore: allList.length == 10,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: StatementStateStatus.error));
    }
  }

  Future<void> _onFetchFilterStatement(
      FetchFilterStatementEvent event,
      Emitter<StatementState> emit,
      ) async {
    try {
      // ⛔️ loading فقط وقتی دیتا نداری
      if (state.allStatement.isEmpty) {
        emit(state.copyWith(status: StatementStateStatus.loading));
      }

      final result = await statementRepository.getFilterStatement(
        depositNumber: event.depositNumber,
        offset: 0,
        endDate: event.endDate,
        startDate: event.startDate,
        statementActionType: event.statementActionType
      );

      final allList = List<StatementModel>.from(result.data!.statements ?? [])
        ..sort((a, b) => b.date!.compareTo(a.date!));

      emit(
        state.copyWith(
          status: StatementStateStatus.success,
          filteredStatement: allList,
          hasMore: allList.length == 10,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: StatementStateStatus.error));
    }
  }

  Future<void> _onLoadAllStatementMore(
      LoadMoreStatementEvent event,
      Emitter<StatementState> emit,
      ) async {
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final res = await statementRepository.getLastestStatement(
      depositNumber: event.depositNumber,
      offset: state.allStatement.length,
    );

    final newList = res.data?.statements ?? [];

    emit(
      state.copyWith(
        allStatement: [...state.allStatement, ...newList],
        hasMore: newList.length == 10,
        isLoadingMore: false,
      ),
    );
  }

  Future<void> _onLoadFilteredStatementMore(
      LoadMoreFilteredStatementEvent event,
      Emitter<StatementState> emit,
      ) async {
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final res = await statementRepository.getFilterStatement(
      depositNumber: event.depositNumber,
      offset: state.filteredStatement.length,
      endDate: event.endDate,
      startDate: event.startDate,
      statementActionType: event.statementActionType
    );

    final newList = res.data?.statements ?? [];

    emit(
      state.copyWith(
        filteredStatement: [...state.filteredStatement, ...newList],
        hasMore: newList.length == 10,
        isLoadingMore: false,
      ),
    );
  }
}
