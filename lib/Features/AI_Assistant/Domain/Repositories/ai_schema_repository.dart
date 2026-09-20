abstract class AiSchemaRepository {
  Future<Map<String, dynamic>> generateUiSchema({
    required String prompt,
  });
}