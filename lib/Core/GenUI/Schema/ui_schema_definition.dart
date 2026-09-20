class UiSchemaDefinition {
  const UiSchemaDefinition._();

  static const Map<String, dynamic> schema = {
    'type': 'object',

    'properties': {
      'type': {
        'type': 'string',
        'enum': [
          'text',
          'dynamic_text',
          'button',
          'column',
        ],
      },

      'value': {
        'type': ['string', 'null'],
      },

      'source': {
        'type': ['string', 'null'],
        'enum': [
          'balance',
          'hasBalance',
          null,
        ],
      },

      'label': {
        'type': ['string', 'null'],
      },

      'action': {
        'type': ['string', 'null'],
        'enum': [
          'show_balance',
          'transfer',
          null,
        ],
      },

      'children': {
        'type': 'array',
        'items': {
          'type': 'object',
          'properties': {
            'type': {
              'type': 'string',
              'enum': [
                'text',
                'dynamic_text',
                'button',
              ],
            },

            'value': {
              'type': ['string', 'null'],
            },

            'source': {
              'type': ['string', 'null'],
              'enum': [
                'balance',
                'hasBalance',
                null,
              ],
            },

            'label': {
              'type': ['string', 'null'],
            },

            'action': {
              'type': ['string', 'null'],
              'enum': [
                'show_balance',
                'transfer',
                null,
              ],
            },
          },

          'required': [
            'type',
            'value',
            'source',
            'label',
            'action',
          ],

          'additionalProperties': false,
        },
      },
    },

    'required': [
      'type',
      'value',
      'source',
      'label',
      'action',
      'children',
    ],

    'additionalProperties': false,
  };
}