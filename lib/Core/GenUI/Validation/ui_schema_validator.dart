import 'package:injectable/injectable.dart';
import '../Actions/ui_action_registry.dart';
import '../State/ui_state_registry.dart';

@lazySingleton
class UiSchemaValidator {
  final UiActionRegistry actionRegistry;
  final UiStateRegistry stateRegistry;

  const UiSchemaValidator({
    required this.actionRegistry,
    required this.stateRegistry,
  });

  void validate(Map<String, dynamic> json) {
    _validateNode(json);
  }

  void _validateNode(
      Map<String, dynamic> json,
      ) {
    final type = json['type'];

    if (type is! String) {
      throw const FormatException(
        'UI node type is required.',
      );
    }

    switch (type) {
      case 'text':
        _validateText(json);
        break;

      case 'dynamic_text':
        _validateDynamicText(json);
        break;

      case 'button':
        _validateButton(json);
        break;

      case 'column':
      case 'card':
        _validateChildren(json);
        break;

      case 'conditional':
        _validateConditional(json);
        break;

      case 'text_field':
        _validateTextField(json);
        break;

      case 'card_selector':
        _validateCardSelector(json);
        break;

      default:
        throw FormatException(
          'Unsupported UI node type: $type',
        );
    }
  }

  void _validateText(Map<String, dynamic> json) {
    _validateAllowedKeys(
      json,
      {
        'type',
        'value',
      },
    );

    if (json['value'] is! String) {
      throw const FormatException(
        'Text node requires a string value.',
      );
    }
  }

  void _validateDynamicText(
      Map<String, dynamic> json,
      ) {

    _validateAllowedKeys(
      json,
      {
        'type',
        'source',
      },
    );

    final source = json['source'];

    if (source is! String) {
      throw const FormatException(
        'Dynamic text node requires a source.',
      );
    }

    if (!stateRegistry.contains(source)) {
      throw FormatException(
        'Unsupported UI state source: $source',
      );
    }
  }

  void _validateButton(
      Map<String, dynamic> json,
      ) {

    _validateAllowedKeys(
      json,
      {
        'type',
        'label',
        'action',
      },
    );

    if (json['label'] is! String) {
      throw const FormatException(
        'Button node requires a label.',
      );
    }

    final action = json['action'];

    if (action is! String) {
      throw const FormatException(
        'Button node requires an action.',
      );
    }

    if (!actionRegistry.contains(action)) {
      throw FormatException(
        'Unsupported UI action: $action',
      );
    }
  }

  void _validateChildren(
      Map<String, dynamic> json,
      ) {

    _validateAllowedKeys(
      json,
      {
        'type',
        'children',
      },
    );

    final children = json['children'];

    if (children is! List) {
      throw const FormatException(
        'This node requires a children list.',
      );
    }

    for (final child in children) {
      if (child is! Map<String, dynamic>) {
        throw const FormatException(
          'Every child must be a UI node object.',
        );
      }

      _validateNode(child);
    }
  }

  void _validateConditional(
      Map<String, dynamic> json,
      ) {
    _validateAllowedKeys(
      json,
      {
        'type',
        'source',
        'operator',
        'value',
        'child',
        'elseChild',
      },
    );

    final source = json['source'];

    if (source is! String) {
      throw const FormatException(
        'Conditional requires a source.',
      );
    }

    if (!stateRegistry.contains(source)) {
      throw FormatException(
        'Unsupported conditional state source: $source',
      );
    }

    final operator = json['operator'];

    if (operator is! String) {
      throw const FormatException(
        'Conditional requires an operator.',
      );
    }

    const supportedOperators = {
      'equals',
      'not_equals',
      'less_than',
      'less_than_or_equal',
      'greater_than',
      'greater_than_or_equal',
    };

    if (!supportedOperators.contains(operator)) {
      throw FormatException(
        'Unsupported conditional operator: $operator',
      );
    }

    if (!json.containsKey('value')) {
      throw const FormatException(
        'Conditional requires a value.',
      );
    }

    final child = json['child'];

    if (child is! Map<String, dynamic>) {
      throw const FormatException(
        'Conditional requires a child.',
      );
    }

    _validateNode(child);

    final elseChild = json['elseChild'];

    if (elseChild != null) {
      if (elseChild is! Map<String, dynamic>) {
        throw const FormatException(
          'Conditional elseChild must be an object.',
        );
      }

      _validateNode(elseChild);
    }
  }

  void _validateTextField(Map<String, dynamic> json) {

    _validateAllowedKeys(
      json,
      {
        'type',
        'label',
        'field',
      },
    );

    if (json['label'] is! String) {
      throw const FormatException(
        'Text field requires a label.',
      );
    }

    if (json['field'] is! String) {
      throw const FormatException(
        'Text field requires a field name.',
      );
    }
  }

  void _validateAllowedKeys(
      Map<String, dynamic> json,
      Set<String> allowedKeys,
      ) {
    for (final key in json.keys) {
      if (!allowedKeys.contains(key)) {
        throw FormatException(
          'Property "$key" is not allowed for node type "${json['type']}".',
        );
      }
    }
  }

  void _validateCardSelector(
      Map<String, dynamic> json,
      ) {
    _validateAllowedKeys(
      json,
      {
        'type',
        'label',
        'source',
        'field',
      },
    );

    if (json['label'] is! String) {
      throw const FormatException(
        'Card selector requires a label.',
      );
    }

    final source = json['source'];

    if (source is! String) {
      throw const FormatException(
        'Card selector requires a source.',
      );
    }

    if (!stateRegistry.contains(source)) {
      throw FormatException(
        'Unsupported card selector state source: $source',
      );
    }

    if (json['field'] is! String) {
      throw const FormatException(
        'Card selector requires a field name.',
      );
    }
  }

}