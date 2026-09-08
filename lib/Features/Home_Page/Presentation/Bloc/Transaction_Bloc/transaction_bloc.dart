import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank/Features/Home_Page/Presentation/Bloc/Transaction_Bloc/transaction_event.dart';
import 'package:neo_bank/Features/Home_Page/Presentation/Bloc/Transaction_Bloc/transaction_state.dart';
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
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      String errorMessage = 'خطا در ارتباط با سرور';

      if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'زمان ارتباط با سرور به پایان رسید';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'سرور پاسخ نمی‌دهد';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'لطفاً اتصال اینترنت خود را بررسی کنید';
      } else if (e.response != null) {
        try {
          final errorData = e.response?.data;
          if (errorData != null) {
            if (errorData is Map) {
              if (errorData.containsKey('message')) {
                errorMessage = errorData['message'].toString();
              } else if (errorData.containsKey('error')) {
                errorMessage = errorData['error'].toString();
              }
            } else if (errorData is String) {
              errorMessage = errorData;
            }
          }
        } catch (_) {}
      }

      emit(state.copyWith(
        status: TransactionStatus.error,
        message: errorMessage,
      ));
    } catch (error) {
      print('❌ خطا: $error');
      print(error);
      emit(state.copyWith(
        status: TransactionStatus.error,
        message: error.toString(),
      ));
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
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      String errorMessage = 'خطا در ارتباط با سرور';

      if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'زمان ارتباط با سرور به پایان رسید';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'سرور پاسخ نمی‌دهد';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'لطفاً اتصال اینترنت خود را بررسی کنید';
      } else if (e.response != null) {
        try {
          final errorData = e.response?.data;
          if (errorData != null) {
            if (errorData is Map) {
              if (errorData.containsKey('message')) {
                errorMessage = errorData['message'].toString();
              } else if (errorData.containsKey('error')) {
                errorMessage = errorData['error'].toString();
              }
            } else if (errorData is String) {
              errorMessage = errorData;
            }
          }
        } catch (_) {}
      }

      emit(state.copyWith(
        status: TransactionStatus.error,
        message: errorMessage,
      ));
    } catch (error) {
      print('❌ خطا: $error');
      print(error);
      emit(state.copyWith(
        status: TransactionStatus.error,
        message: error.toString().replaceFirst(RegExp(r'^Exception:\s*'), ''),
      ));
    }
  }
}