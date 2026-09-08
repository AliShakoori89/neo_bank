import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank/Features/Statement_Page/Presentation/Bloc/Statement_Bloc/statement_event.dart';
import 'package:neo_bank/Features/Statement_Page/Presentation/Bloc/Statement_Bloc/statement_state.dart';
import '../../../Domain/Entities/statement_entity.dart';
import '../../../Domain/UseCases/fetch_statement_filtered_use_case.dart';
import '../../../Domain/UseCases/fetch_statement_use_case.dart';

class StatementBloc extends Bloc<StatementEvent, StatementState> {
  final FetchStatementFilteredUseCase fetchStatementFilteredUseCase;
  final FetchStatementUseCase fetchStatementUseCase;

  StatementBloc(this.fetchStatementFilteredUseCase, this.fetchStatementUseCase) : super(StatementState.initial()) {
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
      // ⛔️ اگر قبلاً در حالت loadingMore بوده، ریست بشه
      emit(state.copyWith(isLoadingMore: false));

      // ⛔️ loading فقط وقتی دیتا نداری
      if (state.allStatement.isEmpty) {
        emit(state.copyWith(status: StatementStateStatus.loading));
      }

      final result = await fetchStatementUseCase.getLastestStatement(
        depositNumber: event.depositNumber,
        offset: 0,
      );

      final allList = List<StatementItemEntity>.from(
        result.statements ?? [],
      )..sort((a, b) => b.date!.compareTo(a.date!));

      emit(
        state.copyWith(
          status: StatementStateStatus.success,
          allStatement: allList,
          hasMore: result.hasMoreItem ?? false,
          isLoadingMore: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: StatementStateStatus.error, isLoadingMore: false));
    }
  }

  Future<void> _onFetchFilterStatement(
    FetchFilterStatementEvent event,
    Emitter<StatementState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: StatementStateStatus.loading,
        filteredStatement: [],
        isLoadingMore: false,
      ));

      final result = await fetchStatementFilteredUseCase.getFilteredStatement(
        depositNumber: event.depositNumber,
        offset: 0,
        endDate: event.endDate,
        startDate: event.startDate,
        statementActionType: event.statementActionType,
      );

      final allList = List<StatementItemEntity>.from(
        result.statements ?? [],
      )..sort((a, b) => b.date!.compareTo(a.date!));

      emit(
        state.copyWith(
          status: StatementStateStatus.success,
          filteredStatement: allList,
          hasMore: result.hasMoreItem ?? false,
          isLoadingMore: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: StatementStateStatus.error, isLoadingMore: false));
    }
  }

  Future<void> _onLoadAllStatementMore(
      LoadMoreStatementEvent event,
      Emitter<StatementState> emit,
      ) async {
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      final res = await fetchStatementUseCase.getLastestStatement(
        depositNumber: event.depositNumber,
        offset: state.allStatement.length,
      );

      final newList = res.statements ?? [];

      emit(
        state.copyWith(
          allStatement: [...state.allStatement, ...newList],
          hasMore: res.hasMoreItem ?? false,
          isLoadingMore: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(isLoadingMore: false));
    }
  }

  Future<void> _onLoadFilteredStatementMore(
      LoadMoreFilteredStatementEvent event,
      Emitter<StatementState> emit,
      ) async {
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      final res = await fetchStatementFilteredUseCase.getFilteredStatement(
          depositNumber: event.depositNumber,
          offset: state.filteredStatement.length,
          endDate: event.endDate,
          startDate: event.startDate,
          statementActionType: event.statementActionType
      );

      final newList = res.statements ?? [];

      emit(
        state.copyWith(
          filteredStatement: [...state.filteredStatement, ...newList],
          hasMore: res.hasMoreItem ?? false,
          isLoadingMore: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(isLoadingMore: false));
    }
  }
}
