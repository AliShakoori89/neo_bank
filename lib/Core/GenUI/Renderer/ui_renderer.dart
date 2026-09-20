import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Features/AI_Assistant/Presentation/Bloc/AI_Assistant_Bloc/ai_assistant_bloc.dart';
import '../../../Features/AI_Assistant/Presentation/Bloc/AI_Assistant_Bloc/ai_assistant_state.dart';
import '../Actions/ui_action_handler.dart';
import '../Models/ui_node_model.dart';
import '../State/ui_state_resolver.dart';

class UiRenderer {
  final UiActionHandler actionHandler;
  final UiStateResolver stateResolver;

  const UiRenderer({
    required this.actionHandler,
    required this.stateResolver,
  });

  Widget render(UiNode node) {
    return switch (node) {
      TextNode(:final value) => Text(
        value,
      ),

      DynamicTextNode(:final source) => Text(
        stateResolver.resolve(source)?.toString() ?? '',
      ),

      ButtonNode(
          :final label,
          :final action,
      ) =>
          ElevatedButton(
            onPressed: () async {
              await actionHandler.execute(action);
            },
            child: Text(label),
          ),

      ColumnNode(
          :final children,
      ) =>
          Column(
            children: children.map(render).toList(),
          ),

      CardNode(
          :final children,
      ) =>
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: children.map(render).toList(),
              ),
            ),
          ),

      ConditionalNode(
          :final source,
          :final operator,
          :final value,
          :final child,
          :final elseChild,
      ) =>
          _renderConditional(
            source: source,
            operator: operator,
            value: value,
            child: child,
            elseChild: elseChild,
          ),

      TextFieldNode(
          :final label,
          :final field,
      ) =>
          TextField(
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
          ),

      CardSelectorNode(
          :final label,
          :final source,
          :final field,
      ) =>
          _renderCardSelector(
            label: label,
            source: source,
            field: field,
          ),
    };
  }

  Widget _renderConditional({
    required String source,
    required String operator,
    required dynamic value,
    required UiNode child,
    required UiNode? elseChild,
  }) {
    final sourceValue = stateResolver.resolve(source);

    final result = _evaluateCondition(
      sourceValue: sourceValue,
      operator: operator,
      value: value,
    );

    if (result) {
      return render(child);
    }

    if (elseChild != null) {
      return render(elseChild);
    }

    return const SizedBox.shrink();
  }

  bool _evaluateCondition({
    required dynamic sourceValue,
    required String operator,
    required dynamic value,
  }) {
    switch (operator) {
      case 'equals':
        return sourceValue.toString() == value.toString();

      case 'not_equals':
        return sourceValue.toString() != value.toString();

      case 'less_than':
        return _toNumber(sourceValue) < _toNumber(value);

      case 'less_than_or_equal':
        return _toNumber(sourceValue) <= _toNumber(value);

      case 'greater_than':
        return _toNumber(sourceValue) > _toNumber(value);

      case 'greater_than_or_equal':
        return _toNumber(sourceValue) >= _toNumber(value);

      default:
        return false;
    }
  }

  double _toNumber(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }

    final normalized = value
        .toString()
        .replaceAll(',', '')
        .replaceAll('٬', '')
        .trim();

    return double.tryParse(normalized) ?? 0;
  }

  Widget _renderCardSelector({
    required String label,
    required String source,
    required String field,
  }) {
    final cards = stateResolver.resolve(source);

    if (cards is! List || cards.isEmpty) {
      return Text(
        '$label: کارتی برای انتخاب وجود ندارد',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        ...cards.map(
              (card) {
            if (card is! Map<String, dynamic>) {
              return const SizedBox.shrink();
            }

            final pan = card['pan']?.toString() ?? '';
            final balance = card['balance']?.toString() ?? '0';
            final depositNumber =
                card['depositNumber']?.toString() ?? '';

            return Card(
              child: ListTile(
                leading: const Icon(
                  Icons.credit_card,
                ),
                title: Text(
                  pan,
                ),
                subtitle: Text(
                  'سپرده: $depositNumber\n'
                      'موجودی: $balance ریال',
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class GeneratedUi extends StatelessWidget {
  final UiActionHandler actionHandler;
  final UiStateResolver stateResolver;

  const GeneratedUi({
    super.key,
    required this.actionHandler,
    required this.stateResolver,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiAssistantBloc, AiAssistantState>(
      builder: (context, state) {
        switch (state) {
          case AiAssistantInitial():
            return const Center(
              child: Text(
                'درخواست خود را وارد کنید',
              ),
            );

          case AiAssistantLoading():
            return const Center(
              child: CircularProgressIndicator(),
            );

          case AiAssistantError(:final message):
            return Center(
              child: Text(
                message,
              ),
            );

          case AiAssistantUiSuccess(:final node):
            return _renderNode(
              node,
            );
        }
      },
    );
  }

  Widget _renderNode(UiNode node) {
    final renderer = UiRenderer(
      actionHandler: actionHandler,
      stateResolver: stateResolver,
    );

    return renderer.render(node);
  }
}