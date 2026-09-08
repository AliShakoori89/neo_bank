import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank/Features/Fund_Transfer_Page/Presentation/Bloc/Account_Tab_Bloc/user_all_account_event.dart';
import 'package:neo_bank/Features/Fund_Transfer_Page/Presentation/Bloc/Account_Tab_Bloc/user_all_account_state.dart';
import '../../../../../Core/Network/app_exception.dart';
import '../../../Domain/UseCases/deposit_use_case.dart';

class UserAllAccountBloc
    extends Bloc<UserAllAccountEvent, UserAllAccountState> {
  final DepositUseCase depositUseCase;

  UserAllAccountBloc({required this.depositUseCase})
    : super(UserAllAccountState.initial()) {
    on<GetUserAllAccountEvent>(_mapGetAllAccounts);
  }

  void _mapGetAllAccounts(
    GetUserAllAccountEvent event,
    Emitter<UserAllAccountState> emit,
  ) async {
    try {
      emit(state.copyWith(status: UserAllAccountStatus.loading));

      final allAccount = await depositUseCase.getUserAllAccount();

      emit(
        state.copyWith(
          status: UserAllAccountStatus.success,
          allAccount: allAccount,
        ),
      );
    } on AppException catch (e) {
      if (e.statusCode == 401) {
        emit(state.copyWith(status: UserAllAccountStatus.tokenExpired));
      } else {
        emit(state.copyWith(status: UserAllAccountStatus.error));
      }
    } catch (error) {
      emit(state.copyWith(status: UserAllAccountStatus.error));
    }
  }
}
