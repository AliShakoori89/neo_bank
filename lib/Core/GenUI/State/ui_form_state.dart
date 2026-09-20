class UiFormState {
  final Map<String, dynamic> values;

  const UiFormState({
    this.values = const {},
  });

  UiFormState copyWith({
    Map<String, dynamic>? values,
  }) {
    return UiFormState(
      values: values ?? this.values,
    );
  }

  dynamic get(String field) {
    return values[field];
  }

  UiFormState set(
      String field,
      dynamic value,
      ) {
    return copyWith(
      values: {
        ...values,
        field: value,
      },
    );
  }
}