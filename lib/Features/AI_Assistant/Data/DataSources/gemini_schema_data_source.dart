import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../Core/GenUI/Schema/gemini_ui_schema_definition.dart';
import 'ai_schema_data_source.dart';

@LazySingleton(as: AiSchemaDataSource)
class GeminiSchemaDataSource implements AiSchemaDataSource {
  final Dio dio;

  GeminiSchemaDataSource({
    @Named('geminiDio') required this.dio,
  });

  @override
  Future<Map<String, dynamic>> generateUiSchema({
    required String prompt,
  }) async {
    const apiKey = '';

    if (apiKey.isEmpty) {
      throw Exception(
        'GEMINI_API_KEY is not configured.',
      );
    }

    try {
      final response = await dio.post(
        '/v1beta/models/gemini-3.6-flash:generateContent',
        queryParameters: {
          'key': apiKey,
        },
        data: {
          'contents': [
            {
              'parts': [
                {
                  'text': '''
You are a banking UI generation assistant.

You must generate ONLY JSON.

Never generate Dart code.

The JSON represents a declarative Flutter UI.

Allowed node types:

1. text

Required properties:
- type
- value

Example:
{
  "type": "text",
  "value": "انتقال وجه"
}

2. dynamic_text

Required properties:
- type
- source

Allowed sources:
- balance
- hasBalance

Example:
{
  "type": "dynamic_text",
  "source": "balance"
}

3. button

Required properties:
- type
- label
- action

Allowed actions:
- show_balance
- transfer

Example:
{
  "type": "button",
  "label": "تایید و انتقال",
  "action": "transfer"
}

4. text_field

Required properties:
- type
- label
- field

The "field" property is the identifier used to store the user's input.

NEVER use "value" for the field identifier.

Example:
{
  "type": "text_field",
  "label": "شماره کارت مقصد",
  "field": "destinationCard"
}

Another example:
{
  "type": "text_field",
  "label": "مبلغ",
  "field": "amount"
}

5. column

Required properties:
- type
- children

Example:
{
  "type": "column",
  "children": []
}

IMPORTANT RULES:

Do not add unrelated properties to a node.

For example, a text_field MUST NOT contain:
- source
- action
- value

A button MUST NOT contain:
- source
- field
- value

A text node MUST NOT contain:
- source
- action
- field

A column MUST NOT contain:
- value
- source
- label
- action

User request:
$prompt
''',
                },
              ],
            },
          ],
          'generationConfig': {
            'responseMimeType': 'application/json',
            'responseSchema': GeminiUiSchemaDefinition.schema,
          },
        },
      );;

      print('GEMINI STATUS: ${response.statusCode}');
      print('GEMINI RESPONSE: ${response.data}');

      final outputText = _extractOutputText(
        response.data,
      );

      final decoded = jsonDecode(
        outputText,
      );

      if (decoded is! Map<String, dynamic>) {
        throw const FormatException(
          'Gemini response is not a valid UI schema.',
        );
      }

      return decoded;
    } on DioException catch (e) {
      print('GEMINI STATUS: ${e.response?.statusCode}');
      print('GEMINI ERROR: ${e.response?.data}');

      rethrow;
    }
  }

  String _extractOutputText(
      Map<String, dynamic> data,
      ) {
    final candidates = data['candidates'];

    if (candidates is! List || candidates.isEmpty) {
      throw const FormatException(
        'Gemini response does not contain candidates.',
      );
    }

    final candidate = candidates.first;

    if (candidate is! Map<String, dynamic>) {
      throw const FormatException(
        'Invalid Gemini candidate.',
      );
    }

    final content = candidate['content'];

    if (content is! Map<String, dynamic>) {
      throw const FormatException(
        'Gemini response does not contain content.',
      );
    }

    final parts = content['parts'];

    if (parts is! List || parts.isEmpty) {
      throw const FormatException(
        'Gemini response does not contain parts.',
      );
    }

    final firstPart = parts.first;

    if (firstPart is! Map<String, dynamic>) {
      throw const FormatException(
        'Invalid Gemini response part.',
      );
    }

    final text = firstPart['text'];

    if (text is! String) {
      throw const FormatException(
        'Gemini response does not contain text.',
      );
    }

    return text;
  }
}