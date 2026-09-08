import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Statement_Page/Data/Model/statement_model.dart';
import '../../../Domain/UseCases/last_transaction_use_case.dart';
import 'last_transaction_event.dart';
import 'last_transaction_state.dart';


class LastTransactionBloc
    extends Bloc<LastTransactionEvent, LastTransactionState> {
  final LastTransactionUseCase lastTransactionUseCase;

  LastTransactionBloc({required this.lastTransactionUseCase})
    : super(LastTransactionState.initial()) {
    on<FetchLastTransactionEvent>(_onFetchLastTransactionEventToState);
  }

  Future<void> _onFetchLastTransactionEventToState(
    FetchLastTransactionEvent event,
    Emitter<LastTransactionState> emit,
  ) async {
    try {
      // ⛔️ loading فقط وقتی دیتا نداری
      if (state.topStatement.isEmpty) {
        emit(state.copyWith(status: SLastTransactionStatus.loading));
      }

      final result = await lastTransactionUseCase.getLastestStatement(
        event.depositNumber,
      );

      final topList = List<StatementModel>.from(result.data!.statements ?? [])
        ..sort((a, b) => b.date!.compareTo(a.date!));

      emit(
        state.copyWith(
          status: SLastTransactionStatus.success,
          topStatement: topList,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: SLastTransactionStatus.error));
    }
  }
}
