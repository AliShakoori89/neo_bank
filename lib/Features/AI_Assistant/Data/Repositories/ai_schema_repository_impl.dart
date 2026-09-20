import 'package:injectable/injectable.dart';
import '../../Domain/Repositories/ai_schema_repository.dart';
import '../DataSources/ai_schema_data_source.dart';

@LazySingleton(as: AiSchemaRepository)
class AiSchemaRepositoryImpl
    implements AiSchemaRepository {
  final AiSchemaDataSource dataSource;

  AiSchemaRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Map<String, dynamic>> generateUiSchema({
    required String prompt,
  }) {
    return dataSource.generateUiSchema(
      prompt: prompt,
    );
  }
}