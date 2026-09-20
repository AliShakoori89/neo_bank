import 'package:injectable/injectable.dart';
import '../Repositories/ai_schema_repository.dart';

@injectable
class GenerateUiSchemaUseCase {
  final AiSchemaRepository repository;

  GenerateUiSchemaUseCase({
    required this.repository,
  });

  Future<Map<String, dynamic>> call({
    required String prompt,
  }) {
    return repository.generateUiSchema(
      prompt: prompt,
    );
  }
}