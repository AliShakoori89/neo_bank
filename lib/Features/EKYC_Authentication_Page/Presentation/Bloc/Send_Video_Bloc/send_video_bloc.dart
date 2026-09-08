import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank/Features/EKYC_Authentication_Page/Presentation/Bloc/Send_Video_Bloc/send_video_event.dart';
import 'package:neo_bank/Features/EKYC_Authentication_Page/Presentation/Bloc/Send_Video_Bloc/send_video_state.dart';

import '../../../Domain/Repository/send_video_repository.dart';

class SendVideoBloc extends Bloc<SendVideoEvent, SendVideoState> {
  final SendVideoRepository sendVideoRepository;

  SendVideoBloc(this.sendVideoRepository) : super(SendVideoState.initial()) {
    on<SendVideoWithTextEvent>(_onSendVideoWithTextEvent);
  }

  Future<void> _onSendVideoWithTextEvent(
      SendVideoWithTextEvent event,
      Emitter<SendVideoState> emit,
      ) async {
    try {
      emit(state.copyWith(status: SendVideoStateStatus.loading));

      final sendVideoResponse = await sendVideoRepository
          .sendVideoResponse(event.randomText, event.fileName, event.content);

      if (sendVideoResponse.success!) {
        emit(
          state.copyWith(
            status: SendVideoStateStatus.success,
            sendVideo: sendVideoResponse,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: SendVideoStateStatus.error,
            errorMessage: sendVideoResponse.error!.errorMessage,
          ),
        );
      }
    } on DioException catch (e) {
      print('❌ DioError: ${e.message}');
      emit(
        state.copyWith(
          status: SendVideoStateStatus.error,
          errorMessage: e.response?.data?.toString() ?? e.message,
        ),
      );
    } catch (error) {
      print('❌ Error: $error');
      emit(
        state.copyWith(
          status: SendVideoStateStatus.error,
          errorMessage: error.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

}