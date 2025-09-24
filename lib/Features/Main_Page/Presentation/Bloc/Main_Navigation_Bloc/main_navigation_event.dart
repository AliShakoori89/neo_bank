abstract class MainNavigationEvent {}

class ChangeTabEvent extends MainNavigationEvent {
  final int index;
  ChangeTabEvent(this.index);
}