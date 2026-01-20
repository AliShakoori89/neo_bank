import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Domain/Repository/Deposits_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Account_Tab_Bloc/user_all_account_event.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Account_Tab_Bloc/user_all_account_state.dart';

class UserAllAccountBloc
    extends Bloc<UserAllAccountEvent, UserAllAccountState> {
  DepositsRepository depositsRepository;

  UserAllAccountBloc(this.depositsRepository)
    : super(UserAllAccountState.initial()) {
    on<GetUserAllAccountEvent>(_mapGetAllCardsPanEvent);
  }

  void _mapGetAllCardsPanEvent(
    GetUserAllAccountEvent event,
    Emitter<UserAllAccountState> emit,
  ) async {
    try {
      emit(state.copyWith(status: UserAllAccountStatus.loading));

      final allAccount = await depositsRepository.getUserAllAccount();

      emit(
        state.copyWith(
          status: UserAllAccountStatus.success,
          allAccount: allAccount,
        ),
      );
    } on DioException catch (e) {
      // if (e.error == 'TOKEN_EXPIRED' || e.response?.statusCode == 401) {
      //   emit(state.copyWith(status: GetAllCardsStatus.tokenExpired));
      // } else {
      //   emit(state.copyWith(status: GetAllCardsStatus.error));
      // }
    } catch (error) {
      emit(state.copyWith(status: UserAllAccountStatus.error));
    }
  }
}
