import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/transaction_model.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Repository/transaction_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Transaction_Bloc/transaction_event.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Transaction_Bloc/transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository transactionRepository;

  TransactionBloc( this.transactionRepository) : super(TransactionState.initial()) {
    on<ChargeTransactionEvent>(_onChargeTransactionEvent);
    on<WithdrawTransactionEvent>(_onWithdrawTransactionEvent);
  }

  void _onChargeTransactionEvent(
      ChargeTransactionEvent event,
      Emitter<TransactionState> emit,
      ) async {
    try {
      emit(state.copyWith(status: TransactionStatus.loading));

      TransactionModel depositResponse = await transactionRepository.chargeWallet(event.customerDepositNumber, event.amount, event.customerWalletAddress);

      emit(
        state.copyWith(status: TransactionStatus.success, transactionModel: depositResponse),
      );
    } on DioException catch (e) {

      emit(state.copyWith(status: TransactionStatus.error));

    } catch (error) {
      emit(state.copyWith(status: TransactionStatus.error));
    }
  }

  void _onWithdrawTransactionEvent(
      WithdrawTransactionEvent event,
      Emitter<TransactionState> emit,
      ) async {
    try {
      emit(state.copyWith(status: TransactionStatus.loading));

      TransactionModel withdrawResponse = await transactionRepository.withdrawWallet(event.customerDepositNumber, event.amount, event.customerWalletAddress);

      emit(
        state.copyWith(status: TransactionStatus.success, transactionModel: withdrawResponse),
      );
    } on DioException catch (e) {

      emit(state.copyWith(status: TransactionStatus.error));

    } catch (error) {
      emit(state.copyWith(status: TransactionStatus.error));
    }
  }
}

