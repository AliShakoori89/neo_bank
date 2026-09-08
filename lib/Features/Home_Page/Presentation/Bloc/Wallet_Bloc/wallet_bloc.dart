import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank/Features/Home_Page/Presentation/Bloc/Wallet_Bloc/wallet_event.dart';
import 'package:neo_bank/Features/Home_Page/Presentation/Bloc/Wallet_Bloc/wallet_state.dart';
import '../../../Domain/UseCases/wallet_use_case.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletUseCase walletUseCase;

  WalletBloc({required this.walletUseCase}) : super(WalletState.initial()) {
    on<WalletDetailsPackagesEvent>(_onWalletDetailsPackagesEvent);
    on<BuyPackagesEvent>(_onBuyPackagesEvent);
  }

  Future<void> _onWalletDetailsPackagesEvent(
      WalletDetailsPackagesEvent event,
      Emitter<WalletState> emit,
      ) async {
    try {
      emit(state.copyWith(status: WalletStateStatus.loading));

      final wallets = await walletUseCase.getWalletDetails();

        emit(
          state.copyWith(
            status: WalletStateStatus.success,
            walletDetails: wallets,
          ),
        );
      } catch (error) {
      print('❌ Error دریافت اطلاعات کیف پول: $error');
      emit(
        state.copyWith(
          status: WalletStateStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onBuyPackagesEvent(
      BuyPackagesEvent event,
      Emitter<WalletState> emit,
      ) async {
    try {
      emit(state.copyWith(status: WalletStateStatus.loading));

      final purchaseResult = await walletUseCase.buyInternetPackage(
        sourceMobileNumber: event.sourceMobileNumber,
        walletAddress: event.walletAddress,
        productCode: event.productCode,
        destMobileNumber: event.destMobileNumber,
      );

      print('✅ خرید بسته اینترنت: $purchaseResult');

      emit(
        state.copyWith(
          status: WalletStateStatus.purchaseSuccess,
          purchaseData: purchaseResult,
        ),
      );
    } on DioException catch (e) {
      print('❌ DioError در خرید: ${e.message}');
      emit(
        state.copyWith(
          status: WalletStateStatus.error,
          errorMessage: e.response?.data?.toString() ?? e.message,
        ),
      );
    } catch (error) {
      print('❌ Error در خرید: $error');
      emit(
        state.copyWith(
          status: WalletStateStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}