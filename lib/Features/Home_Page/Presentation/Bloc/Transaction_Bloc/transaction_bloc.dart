import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank/Features/Home_Page/Presentation/Bloc/Transaction_Bloc/transaction_event.dart';
import 'package:neo_bank/Features/Home_Page/Presentation/Bloc/Transaction_Bloc/transaction_state.dart';
import '../../../../../Core/Network/app_exception.dart';
import '../../../Domain/UseCases/transaction_use_case.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionUseCase transactionUseCase;

  TransactionBloc({required this.transactionUseCase}) : super(TransactionState.initial()) {
    on<ChargeTransactionEvent>(_onChargeTransactionEvent);
    on<WithdrawTransactionEvent>(_onWithdrawTransactionEvent);
    // حذف ResetTransactionEvent - نیازی به آن نیست
  }

  Future<void> _onChargeTransactionEvent(
      ChargeTransactionEvent event,
      Emitter<TransactionState> emit,
      ) async {
    try {
      // emit loading state
      emit(state.copyWith(
        status: TransactionStatus.loading,
        message: null,
      ));

      final response = await transactionUseCase.chargeWallet(
        customerWalletAddress: event.customerWalletAddress,
        amount: event.amount,
        customerDepositNumber: event.customerDepositNumber,
      );

      if (response.success) {
        // بررسی تراکنش تکراری
        final isDuplicate = response.data.transactionNumber == 'تراکنش تکراری است' ||
            response.data.transactionNumber.contains('تکراری');

        if (isDuplicate) {
          emit(state.copyWith(
            status: TransactionStatus.error,
            message: 'این تراکنش قبلاً انجام شده است',
          ));
        } else {
          emit(state.copyWith(
            status: TransactionStatus.success,
            transactionNumber: response.data.transactionNumber,
            traceId: response.traceId,
            message: 'تراکنش با موفقیت انجام شد',
          ));
        }
      } else {
        emit(state.copyWith(
          status: TransactionStatus.error,
          message: response.error?.toString() ?? 'خطا در شارژ کیف پول',
        ));
      }
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: TransactionStatus.error,
          message: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TransactionStatus.error,
          message: 'خطای ناشناخته رخ داده است',
        ),
      );
    }
  }

  Future<void> _onWithdrawTransactionEvent(
      WithdrawTransactionEvent event,
      Emitter<TransactionState> emit,
      ) async {
    try {
      // emit loading state
      emit(state.copyWith(
        status: TransactionStatus.loading,
        message: null,
      ));

      final response = await transactionUseCase.withdrawWallet(
        customerWalletAddress: event.customerWalletAddress,
        amount: event.amount,
        customerDepositNumber: event.customerDepositNumber,
      );

      print('Response success: ${response.success}');
      print('Response data: ${response.data.transactionNumber}');

      if (response.success) {
        // بررسی تراکنش تکراری
        final isDuplicate = response.data.transactionNumber == 'تراکنش تکراری است' ||
            response.data.transactionNumber.contains('تکراری');

        if (isDuplicate) {
          emit(state.copyWith(
            status: TransactionStatus.error,
            message: 'این تراکنش قبلاً انجام شده است',
          ));
        } else {
          emit(state.copyWith(
            status: TransactionStatus.success,
            transactionNumber: response.data.transactionNumber,
            traceId: response.traceId,
            message: 'تراکنش با موفقیت انجام شد',
          ));
        }
      } else {
        emit(state.copyWith(
          status: TransactionStatus.error,
          message: response.error?.toString() ?? 'خطا در برداشت از کیف پول',
        ));
      }
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: TransactionStatus.error,
          message: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TransactionStatus.error,
          message: 'خطای ناشناخته رخ داده است',
        ),
      );
    }
  }
}