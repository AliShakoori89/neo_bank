abstract class UserLoginAuthEvent {
  List<Object> get props => [];
}

class UserLoginEvent extends UserLoginAuthEvent {
  final String nationalCode;
  final String phoneNumber;

  UserLoginEvent({required this.nationalCode, required this.phoneNumber});

  @override
  List<Object> get props => [nationalCode, phoneNumber];
}

class UserIsLoginEvent extends UserLoginAuthEvent {}

class LogoutEvent extends UserLoginAuthEvent {}
