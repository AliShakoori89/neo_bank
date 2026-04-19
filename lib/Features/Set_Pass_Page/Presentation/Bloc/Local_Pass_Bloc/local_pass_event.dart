abstract class LocalPassEvent {
  List<Object> get props => [];
}

class SetPassEvent extends LocalPassEvent{
  final String pass;

  SetPassEvent({required this.pass});

  @override
  List<Object> get props => [pass];
}

class IsFirstLoginEvent extends LocalPassEvent{}

class FetchLocalPassEvent extends LocalPassEvent{}

