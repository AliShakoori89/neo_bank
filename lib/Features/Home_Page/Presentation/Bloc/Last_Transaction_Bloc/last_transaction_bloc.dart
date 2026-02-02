import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Repository/last_transaction_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Last_Transaction_Bloc/last_transaction_event.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Last_Transaction_Bloc/last_transaction_state.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Data/Model/statement_model.dart';

class LastTransactionBloc
    extends Bloc<LastTransactionEvent, LastTransactionState> {
  final LastTransactionRepository lastTransactionRepository;

  LastTransactionBloc(this.lastTransactionRepository)
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

      final result = await lastTransactionRepository.getLastestStatement(
        event.depositNumber,
      );

      final allList = List<StatementDataModel>.from(result.data ?? [])
        ..sort((a, b) => b.date!.compareTo(a.date!));

      final topList = event.latestCount == null
          ? allList
          : allList.take(event.latestCount!).toList();

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
