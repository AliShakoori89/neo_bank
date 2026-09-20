class GeminiUiSchemaDefinition {
  const GeminiUiSchemaDefinition._();

  static const Map<String, dynamic> schema = {
    'anyOf': [
      _textNode,
      _dynamicTextNode,
      _buttonNode,
      _textFieldNode,
      _cardSelectorNode,
      _columnNode,
      _cardNode,
      _conditionalNode,
    ],
  };

  static const Map<String, dynamic> _textNode = {
    'type': 'OBJECT',
    'properties': {
      'type': {
        'type': 'STRING',
        'enum': ['text'],
      },
      'value': {
        'type': 'STRING',
      },
    },
    'required': [
      'type',
      'value',
    ],
  };

  static const Map<String, dynamic> _dynamicTextNode = {
    'type': 'OBJECT',
    'properties': {
      'type': {
        'type': 'STRING',
        'enum': ['dynamic_text'],
      },
      'source': {
        'type': 'STRING',
        'enum': [
          'balance',
          'hasBalance',
        ],
      },
    },
    'required': [
      'type',
      'source',
    ],
  };

  static const Map<String, dynamic> _buttonNode = {
    'type': 'OBJECT',
    'properties': {
      'type': {
        'type': 'STRING',
        'enum': ['button'],
      },
      'label': {
        'type': 'STRING',
      },
      'action': {
        'type': 'STRING',
        'enum': [
          'show_balance',
          'transfer',
        ],
      },
    },
    'required': [
      'type',
      'label',
      'action',
    ],
  };

  static const Map<String, dynamic> _textFieldNode = {
    'type': 'OBJECT',
    'properties': {
      'type': {
        'type': 'STRING',
        'enum': ['text_field'],
      },
      'label': {
        'type': 'STRING',
      },
      'field': {
        'type': 'STRING',
      },
    },
    'required': [
      'type',
      'label',
      'field',
    ],
  };

  static const Map<String, dynamic> _columnNode = {
    'type': 'OBJECT',
    'properties': {
      'type': {
        'type': 'STRING',
        'enum': ['column'],
      },
      'children': {
        'type': 'ARRAY',
        'items': {
          'anyOf': [
            _textNode,
            _dynamicTextNode,
            _buttonNode,
            _textFieldNode,
            _cardSelectorNode,
          ],
        },
      },
    },
    'required': [
      'type',
      'children',
    ],
  };

  static const Map<String, dynamic> _cardNode = {
    'type': 'OBJECT',
    'properties': {
      'type': {
        'type': 'STRING',
        'enum': ['card'],
      },
      'children': {
        'type': 'ARRAY',
        'items': {
          'anyOf': [
            _textNode,
            _dynamicTextNode,
            _buttonNode,
            _textFieldNode,
            _cardSelectorNode,
          ],
        },
      },
    },
    'required': [
      'type',
      'children',
    ],
  };

  static const Map<String, dynamic> _conditionalNode = {
    'type': 'OBJECT',
    'properties': {
      'type': {
        'type': 'STRING',
        'enum': ['conditional'],
      },
      'source': {
        'type': 'STRING',
        'enum': ['balance', 'hasBalance'],
      },
      'operator': {
        'type': 'STRING',
        'enum': [
          'equals',
          'not_equals',
          'less_than',
          'less_than_or_equal',
          'greater_than',
          'greater_than_or_equal',
        ],
      },
      'value': {
        'type': 'STRING',
      },
      'child': {
        'anyOf': [
          _textNode,
          _dynamicTextNode,
          _buttonNode,
          _textFieldNode,
          _columnNode,
          _cardNode,
        ],
      },
      'elseChild': {
        'anyOf': [
          _textNode,
          _dynamicTextNode,
          _buttonNode,
          _textFieldNode,
          _columnNode,
          _cardNode,
        ],
      },
    },
    'required': [
      'type',
      'source',
      'operator',
      'value',
      'child',
    ],
  };

  static const Map<String, dynamic> _cardSelectorNode = {
    'type': 'OBJECT',
    'properties': {
      'type': {
        'type': 'STRING',
        'enum': ['card_selector'],
      },
      'label': {
        'type': 'STRING',
      },
      'source': {
        'type': 'STRING',
        'enum': ['user_cards'],
      },
      'field': {
        'type': 'STRING',
      },
    },
    'required': [
      'type',
      'label',
      'source',
      'field',
    ],
  };
}