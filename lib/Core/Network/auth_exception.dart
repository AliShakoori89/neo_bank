class AuthException implements Exception {
  final String message;

  AuthException([
    this.message = 'نشست شما منقضی شده است.',
  ]);

  @override
  String toString() => message;
}