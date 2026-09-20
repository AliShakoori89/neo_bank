abstract class AiSchemaDataSource {
  Future<Map<String, dynamic>> generateUiSchema({
    required String prompt,
  });
}