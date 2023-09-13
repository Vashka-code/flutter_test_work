abstract class MainPageEvent {}

class TabChange extends MainPageEvent {
  final int tabIndex;

  TabChange({required this.tabIndex});
}
