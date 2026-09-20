import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../Core/GenUI/Models/ui_node_model.dart';
import '../../../../../Core/GenUI/Validation/ui_schema_validator.dart';
import '../../../Domain/UseCases/generate_ui_schema_use_case.dart';
import 'ai_assistant_event.dart';
import 'ai_assistant_state.dart';

@injectable
class AiAssistantBloc
    extends Bloc<AiAssistantEvent, AiAssistantState> {
  final GenerateUiSchemaUseCase generateUiSchemaUseCase;
  final UiSchemaValidator validator;

  AiAssistantBloc({
    required this.generateUiSchemaUseCase,
    required this.validator,
  }) : super(
    const AiAssistantInitial(),
  ) {
    on<GenerateUiEvent>(
      _onGenerateUi,
    );
  }

  Future<void> _onGenerateUi(
      GenerateUiEvent event,
      Emitter<AiAssistantState> emit,
      ) async {
    emit(
      const AiAssistantLoading(),
    );

    try {
      final json = await generateUiSchemaUseCase(
        prompt: event.prompt,
      );

      validator.validate(json);

      final node = UiNode.fromJson(
        json,
      );

      emit(
        AiAssistantUiSuccess(
          node: node,
        ),
      );
    } catch (e) {

      print(e.toString());
      emit(
        AiAssistantError(
          message: e.toString(),
        ),
      );
    }
  }
}