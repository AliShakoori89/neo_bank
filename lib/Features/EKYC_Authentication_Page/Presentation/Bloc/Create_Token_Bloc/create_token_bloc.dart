import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Data/Model/create_token_model.dart';
import '../../../Domain/Repository/create_token_repository.dart';
import 'create_token_event.dart';
import 'create_token_state.dart';

class CreateTokenBloc extends Bloc<CreateTokenEvent, CreateTokenState> {
  final CreateTokenRepository createTokenRepository;

  CreateTokenBloc(this.createTokenRepository) : super(CreateTokenState.initial()) {
    on<CreateTokenResponseEvent>(_onCreateTokenResponseEvent);
  }

  Future<void> _onCreateTokenResponseEvent(
      CreateTokenResponseEvent event,
      Emitter<CreateTokenState> emit,
      ) async {
    try {
      emit(state.copyWith(status: CreateTokenStateStatus.loading));

      final CreateTokenModel createTokenResponse = await createTokenRepository.createTokenResponse(event.cardSerialNo, event.cardExpDate);

      if (createTokenResponse.success!) {
        emit(
          state.copyWith(
            status: CreateTokenStateStatus.success,
            createTokenResponse: createTokenResponse,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: CreateTokenStateStatus.error,
            errorMessage: createTokenResponse.error!.errorMessage,
          ),
        );
      }
    } on DioException catch (e) {
      print('❌ DioError: ${e.message}');
      emit(
        state.copyWith(
          status: CreateTokenStateStatus.error,
          errorMessage: e.response?.data?.toString() ?? e.message,
        ),
      );
    } catch (error) {
      print('❌ Error: $error');
      emit(
        state.copyWith(
          status: CreateTokenStateStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

}