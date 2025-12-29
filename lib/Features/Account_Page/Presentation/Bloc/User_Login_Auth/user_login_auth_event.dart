abstract class UserLoginAuthEvent {
  List<Object> get props => [];
}

class UserLoginEvent extends UserLoginAuthEvent {
  final String username;
  final String password;

  UserLoginEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class UserIsLoginEvent extends UserLoginAuthEvent {}
