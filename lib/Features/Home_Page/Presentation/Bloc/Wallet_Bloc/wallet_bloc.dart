import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Wallet_Bloc/wallet_event.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Wallet_Bloc/wallet_state.dart';

import '../../../Domain/Repository/wallet_repository.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository walletRepository;

  WalletBloc( this.walletRepository) : super(WalletState.initial()) {
    on<WalletDetailsPackagesEvent>(_onWalletDetailsPackagesEvent);
    on<BuyPackagesEvent>(_onBuyPackagesEvent);
  }

  void _onWalletDetailsPackagesEvent(
      WalletDetailsPackagesEvent event,
      Emitter<WalletState> emit,
      ) async {
    try {
      emit(state.copyWith(status: WalletStateStatus.loading));

      final walletDetails = await walletRepository.getWalletDetails();
      print(walletDetails);

      emit(
        state.copyWith(status: WalletStateStatus.success, walletDetails: walletDetails),
      );
    } on DioException catch (e) {

      emit(state.copyWith(status: WalletStateStatus.error));

    } catch (error) {
      emit(state.copyWith(status: WalletStateStatus.error));
    }
  }

  void _onBuyPackagesEvent(
      BuyPackagesEvent event,
      Emitter<WalletState> emit,
      ) async {
    try {
      emit(state.copyWith(status: WalletStateStatus.loading));

      final walletDetails = await walletRepository.buyInternetPackage();
      print(walletDetails);

      emit(
        state.copyWith(status: WalletStateStatus.success, walletDetails: walletDetails),
      );
    } on DioException catch (e) {

      emit(state.copyWith(status: WalletStateStatus.error));

    } catch (error) {
      emit(state.copyWith(status: WalletStateStatus.error));
    }
  }

}