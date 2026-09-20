sealed class AccountState {
  const AccountState();
}

class AccountInitial extends AccountState {
  const AccountInitial();
}

class AccountLoading extends AccountState {
  const AccountLoading();
}

class AccountSuccess extends AccountState {
  final String balance;

  const AccountSuccess({
    required this.balance,
  });
}

class AccountError extends AccountState {
  final String message;

  const AccountError({
    required this.message,
  });
}