// import 'package:injectable/injectable.dart';
//
// import 'ai_schema_data_source.dart';
//
// @LazySingleton(as: AiSchemaDataSource)
// class FakeAiSchemaDataSource implements AiSchemaDataSource {
//   FakeAiSchemaDataSource();
//
//   @override
//   Future<Map<String, dynamic>> generateUiSchema({
//     required String prompt,
//   }) async {
//     await Future.delayed(const Duration(milliseconds: 500));
//
//     return {
//       'type': 'column',
//       'value': null,
//       'source': null,
//       'label': null,
//       'action': null,
//       'children': [
//         {
//           'type': 'dynamic_text',
//           'value': null,
//           'source': 'balance',
//           'label': null,
//           'action': null,
//         },
//         {
//           'type': 'button',
//           'value': null,
//           'source': null,
//           'label': 'مشاهده موجودی',
//           'action': 'show_balance',
//         },
//       ],
//     };
//   }
// }
