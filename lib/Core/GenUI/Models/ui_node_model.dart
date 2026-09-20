sealed class UiNode {
  const UiNode();

  factory UiNode.fromJson(Map<String, dynamic> json) {
    final type = json['type'];

    if (type is! String) {
      throw const FormatException(
        'UI node type is required.',
      );
    }

    switch (type) {
      case 'text':
        return TextNode.fromJson(json);

      case 'dynamic_text':
        return DynamicTextNode.fromJson(json);

      case 'button':
        return ButtonNode.fromJson(json);

      case 'text_field':
        return TextFieldNode.fromJson(json);

      case 'column':
        return ColumnNode.fromJson(json);

      case 'card':
        return CardNode.fromJson(json);

      case 'conditional':
        return ConditionalNode.fromJson(json);

      case 'card_selector':
        return CardSelectorNode.fromJson(json);

      default:
        throw UnsupportedError(
          'Unsupported UI node type: $type',
        );
    }
  }
}

class TextNode extends UiNode {
  final String value;

  const TextNode({
    required this.value,
  });

  factory TextNode.fromJson(Map<String, dynamic> json) {
    return TextNode(
      value: json['value'] as String,
    );
  }
}

class DynamicTextNode extends UiNode {
  final String source;

  const DynamicTextNode({
    required this.source,
  });

  factory DynamicTextNode.fromJson(
      Map<String, dynamic> json,
      ) {
    return DynamicTextNode(
      source: json['source'] as String,
    );
  }
}

class ButtonNode extends UiNode {
  final String label;
  final String action;

  const ButtonNode({
    required this.label,
    required this.action,
  });

  factory ButtonNode.fromJson(
      Map<String, dynamic> json,
      ) {
    return ButtonNode(
      label: json['label'] as String,
      action: json['action'] as String,
    );
  }
}

class TextFieldNode extends UiNode {
  final String label;
  final String field;

  const TextFieldNode({
    required this.label,
    required this.field,
  });

  factory TextFieldNode.fromJson(
      Map<String, dynamic> json,
      ) {
    return TextFieldNode(
      label: json['label'] as String,
      field: json['field'] as String,
    );
  }
}

class ColumnNode extends UiNode {
  final List<UiNode> children;

  const ColumnNode({
    required this.children,
  });

  factory ColumnNode.fromJson(
      Map<String, dynamic> json,
      ) {
    final children = json['children'];

    if (children is! List) {
      throw const FormatException(
        'Column requires children.',
      );
    }

    return ColumnNode(
      children: children
          .map(
            (child) => UiNode.fromJson(
          child as Map<String, dynamic>,
        ),
      )
          .toList(),
    );
  }
}

class CardNode extends UiNode {
  final List<UiNode> children;

  const CardNode({
    required this.children,
  });

  factory CardNode.fromJson(
      Map<String, dynamic> json,
      ) {
    final children = json['children'];

    if (children is! List) {
      throw const FormatException(
        'Card requires children.',
      );
    }

    return CardNode(
      children: children
          .map(
            (child) => UiNode.fromJson(
          child as Map<String, dynamic>,
        ),
      )
          .toList(),
    );
  }
}

class ConditionalNode extends UiNode {
  final String source;
  final String operator;
  final dynamic value;
  final UiNode child;
  final UiNode? elseChild;

  const ConditionalNode({
    required this.source,
    required this.operator,
    required this.value,
    required this.child,
    this.elseChild,
  });

  factory ConditionalNode.fromJson(
      Map<String, dynamic> json,
      ) {
    final child = json['child'];

    if (child is! Map<String, dynamic>) {
      throw const FormatException(
        'Conditional requires a child.',
      );
    }

    final elseChild = json['elseChild'];

    return ConditionalNode(
      source: json['source'] as String,
      operator: json['operator'] as String,
      value: json['value'],
      child: UiNode.fromJson(child),
      elseChild: elseChild is Map<String, dynamic>
          ? UiNode.fromJson(elseChild)
          : null,
    );
  }
}

class CardSelectorNode extends UiNode {
  final String label;
  final String source;
  final String field;

  const CardSelectorNode({
    required this.label,
    required this.source,
    required this.field,
  });

  factory CardSelectorNode.fromJson(
      Map<String, dynamic> json,
      ) {
    return CardSelectorNode(
      label: json['label'] as String,
      source: json['source'] as String,
      field: json['field'] as String,
    );
  }
}