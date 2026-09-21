import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../Domain/UseCases/get_balance_use_case.dart';
import 'account_event.dart';
import 'account_state.dart';

@injectable
class AccountBloc
    extends Bloc<AccountEvent, AccountState> {
  final GetBalanceUseCase getBalanceUseCase;

  AccountBloc({
    required this.getBalanceUseCase,
  }) : super(
    const AccountInitial(),
  ) {
    on<GetBalanceEvent>(
      _onGetBalance,
    );
  }

  Future<void> _onGetBalance(
      GetBalanceEvent event,
      Emitter<AccountState> emit,
      ) async {
    emit(
      const AccountLoading(),
    );

    try {
      final balance = await getBalanceUseCase();

      emit(
        AccountSuccess(
          balance: balance,
        ),
      );
    } catch (e) {
      emit(
        AccountError(
          message: e.toString(),
        ),
      );
    }
  }
}