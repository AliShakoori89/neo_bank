import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Repository/get_internet_packages_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Wallet_Bloc/wallet_event.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Wallet_Bloc/wallet_state.dart';

import '../../../Domain/Repository/wallet_repository.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository walletRepository;

  WalletBloc( this.walletRepository) : super(WalletState.initial()) {
    on<WalletDetailsPackages>(_onWalletDetailsPackagesEvent);
  }

  void _onWalletDetailsPackagesEvent(
      WalletDetailsPackages event,
      Emitter<WalletState> emit,
      ) async {
    try {
      emit(state.copyWith(status: WalletStateStatus.loading));

      final internetPackage = await walletRepository.getWalletDetails();
      print(internetPackage);

      emit(
        state.copyWith(status: WalletStateStatus.success, internetPackages: internetPackage),
      );
    } on DioException catch (e) {

      emit(state.copyWith(status: WalletStateStatus.error));

    } catch (error) {
      emit(state.copyWith(status: WalletStateStatus.error));
    }
  }

}