import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank/Features/EKYC_Authentication_Page/Presentation/Bloc/Random_Text_Bloc/random_text_event.dart';
import 'package:neo_bank/Features/EKYC_Authentication_Page/Presentation/Bloc/Random_Text_Bloc/random_text_state.dart';

import '../../../Domain/Repository/random_text_repository.dart';

class RandomTextBloc extends Bloc<RandomTextEvent, RandomTextState> {
  final RandomTextRepository randomTextRepository;

  RandomTextBloc(this.randomTextRepository) : super(RandomTextState.initial()) {
    on<GetRandomTextEvent>(_onGetRandomTextEvent);
  }

  Future<void> _onGetRandomTextEvent(
      GetRandomTextEvent event,
      Emitter<RandomTextState> emit,
      ) async {
    try {
      emit(state.copyWith(status: RandomTextStateStatus.loading));

      final getRandomText = await randomTextRepository
          .getRandomText();

      print(getRandomText);

      if (getRandomText.success!) {
        emit(
          state.copyWith(
            status: RandomTextStateStatus.success,
            randomText: getRandomText,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: RandomTextStateStatus.error,
            errorMessage: getRandomText.error!.errorMessage,
          ),
        );
      }
    } on DioException catch (e) {
      print('❌ DioError: ${e.message}');
      emit(
        state.copyWith(
          status: RandomTextStateStatus.error,
          errorMessage: e.response?.data?.toString() ?? e.message,
        ),
      );
    } catch (error) {
      print('❌ Error: $error');
      emit(
        state.copyWith(
          status: RandomTextStateStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

}