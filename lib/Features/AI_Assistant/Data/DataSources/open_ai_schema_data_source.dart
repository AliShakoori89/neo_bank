import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../Core/GenUI/Schema/ui_schema_definition.dart';
import 'ai_schema_data_source.dart';

// @LazySingleton(as: AiSchemaDataSource)
// @LazySingleton()
class OpenAiSchemaDataSource
    implements AiSchemaDataSource {
  final Dio dio;

  OpenAiSchemaDataSource({
    required this.dio,
  });

  @override
  Future<Map<String, dynamic>> generateUiSchema({
    required String prompt,
  }) async {
    const apiKey = String.fromEnvironment(
      'OPENAI_API_KEY',
    );

    if (apiKey.isEmpty) {
      throw Exception(
        'OPENAI_API_KEY is not configured.',
      );
    }

try {
    final response = await dio.post(
      'https://api.openai.com/v1/responses',
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'model': 'gpt-5.6-luna',

        'instructions': '''
You are a banking UI generation assistant.

You must NEVER generate Dart code.

You must ONLY generate JSON.

The JSON must follow the provided UI schema.

Allowed UI node types:
- text
- dynamic_text
- button
- column

Allowed state sources:
- balance
- hasBalance

Allowed actions:
- show_balance
- transfer

Never invent new actions.

Never invent new state sources.

The generated UI must be declarative and safe.
''',

        'input': prompt,

        'text': {
          'format': {
            'type': 'json_schema',
            'name': 'ui_schema',
            'strict': true,
            'schema': UiSchemaDefinition.schema,
          },
        },
      },
    );

    print('OPENAI STATUS: ${response.statusCode}');
    print('OPENAI RESPONSE: ${response.data}');

    final outputText = _extractOutputText(
      response.data,
    );

    final decoded = jsonDecode(
      outputText,
    );

    if (decoded is! Map<String, dynamic>) {
      throw const FormatException(
        'AI response is not a valid UI schema.',
      );
    }

    return decoded;
    } on DioException catch (e) {
      print('OPENAI STATUS: ${e.response?.statusCode}');
      print('OPENAI ERROR: ${e.response?.data}');

      rethrow;
    }
  }

  String _extractOutputText(
      Map<String, dynamic> data,
      ) {
    final output = data['output'];

    if (output is! List) {
      throw const FormatException(
        'OpenAI response does not contain output.',
      );
    }

    for (final item in output) {
      if (item is! Map<String, dynamic>) {
        continue;
      }

      final content = item['content'];

      if (content is! List) {
        continue;
      }

      for (final contentItem in content) {
        if (contentItem is! Map<String, dynamic>) {
          continue;
        }

        final text = contentItem['text'];

        if (text is String) {
          return text;
        }
      }
    }

    throw const FormatException(
      'No text output found in OpenAI response.',
    );
  }
}