import 'package:hooks_riverpod/hooks_riverpod.dart';

enum TabType {
  today,
  books,
  profile,
}

final tabTypeProvider = StateNotifierProvider<TabTypeViewModel, TabType>(
    (ref) => TabTypeViewModel());

class TabTypeViewModel extends StateNotifier<TabType> {
  TabTypeViewModel() : super(TabType.books);

  void updateTab(int index) {
    state = TabType.values[index];
  }
}
