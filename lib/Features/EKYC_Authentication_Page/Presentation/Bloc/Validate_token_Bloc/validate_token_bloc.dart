import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Domain/Repository/validate_token_repository.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Presentation/Bloc/Validate_token_Bloc/validate_token_event.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Presentation/Bloc/Validate_token_Bloc/validate_token_state.dart';

class ValidateTokenBloc extends Bloc<ValidateTokenEvent, ValidateTokenState> {
  final ValidateTokenRepository validateTokenRepository;

  ValidateTokenBloc(this.validateTokenRepository) : super(ValidateTokenState.initial()) {
    on<ValidateTokenResponseEvent>(_onValidateTokenResponseEvent);
  }

  Future<void> _onValidateTokenResponseEvent(
      ValidateTokenResponseEvent event,
      Emitter<ValidateTokenState> emit,
      ) async {
    try {
      emit(state.copyWith(status: ValidateTokenStateStatus.loading));

      final validateTokenResponse = await validateTokenRepository.validateTokenResponse(event.tokenValue, event.orderId, event.tokenExpirationDateTime);

      print(validateTokenResponse.data);

      if (validateTokenResponse.success!) {
        emit(
          state.copyWith(
            status: ValidateTokenStateStatus.success,
            validateTokenResponse: validateTokenResponse,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ValidateTokenStateStatus.error,
            errorMessage: validateTokenResponse.error!.errorMessage,
          ),
        );
      }
    } on DioException catch (e) {
      print('❌ DioError: ${e.message}');
      emit(
        state.copyWith(
          status: ValidateTokenStateStatus.error,
          errorMessage: e.response?.data?.toString() ?? e.message,
        ),
      );
    } catch (error) {
      print('❌ Error: $error');
      emit(
        state.copyWith(
          status: ValidateTokenStateStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

}