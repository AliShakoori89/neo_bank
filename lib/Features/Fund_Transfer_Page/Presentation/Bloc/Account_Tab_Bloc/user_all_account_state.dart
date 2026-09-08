import 'package:equatable/equatable.dart';
import '../../../Domain/Entities/deposit_entity.dart';

enum UserAllAccountStatus { initial, success, error, loading, tokenExpired }

extension UserAllAccountStatusX on UserAllAccountStatus {
  bool get isInitial => this == UserAllAccountStatus.initial;
  bool get isSuccess => this == UserAllAccountStatus.success;
  bool get isError => this == UserAllAccountStatus.error;
  bool get isLoading => this == UserAllAccountStatus.loading;
}

class UserAllAccountState extends Equatable {
  const UserAllAccountState({required this.status, this.allAccount});

  static UserAllAccountState initial() => UserAllAccountState(
    status: UserAllAccountStatus.initial,
    allAccount: <DepositEntity>[],
  );

  final UserAllAccountStatus status;
  final List<DepositEntity>? allAccount;

  @override
  List<Object?> get props => [status, allAccount];

  UserAllAccountState copyWith({
    UserAllAccountStatus? status,
    List<DepositEntity>? allAccount,
  }) {
    return UserAllAccountState(
      status: status ?? this.status,
      allAccount: allAccount ?? this.allAccount,
    );
  }
}
