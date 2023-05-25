import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/service/goal_service.dart';

import '../component/constants.dart';
import '../infrastructure/record_repository.dart';
import '../model/book_model.dart';
import '../model/goal_model.dart';
import '../model/record_model.dart';

final goalCellsProvider =
    StateNotifierProvider<GoalCellsViewModel, AsyncValue<List<GoalCell>>>(
        (ref) {
  return GoalCellsViewModel();
});

class GoalCellsViewModel extends StateNotifier<AsyncValue<List<GoalCell>>> {
  GoalCellsViewModel() : super(const AsyncValue.loading());

  final recordRepository = RecordRepository();
  final goalListViewModel = GoalsService();

  List<Record> getCheckedRecords(Book book, int duration) {
    List<GoalCell> checked =
        state.value!.where((goalcell) => goalcell.checked).toList();
    checked.sort((a, b) => a.number.compareTo(b.number));
    // 連番を範囲データに変換
    final singlePageDuration = (duration / (checked.length)).round();
    List<Record> records = [];
    Record? current;
    for (var goalcell in checked) {
      if (current == null) {
        current = Record(
          start: goalcell.number,
          last: goalcell.number,
          duration: singlePageDuration,
          recordedAt: DateTime.now(),
          startedAt: DateTime.now(),
          bookId: book.id!,
          userId: supabase.auth.currentUser!.id,
        );
      } else {
        if (current.last + 1 == goalcell.number) {
          current = current.copyWith(
              last: goalcell.number,
              duration: current.duration + singlePageDuration);
        } else {
          records.add(current);
          current = Record(
            start: goalcell.number,
            last: goalcell.number,
            duration: singlePageDuration,
            recordedAt: DateTime.now(),
            startedAt: DateTime.now(),
            bookId: book.id!,
            userId: supabase.auth.currentUser!.id,
          );
        }
      }
    }
    if (current != null) {
      records.add(current);
    }
    return records;
  }

  void uncheckAll() {
    state = AsyncValue.data(state.value!
        .map((goalCell) => GoalCell(
            number: goalCell.number, done: goalCell.done, checked: false))
        .toList());
  }

  Future<void> checkTodayTask(Goal goal) async {
    final oldState = state;
    state = const AsyncValue.loading();
    final List<int> tasks =
        (await goalListViewModel.getTaskInformationFromGoal(goal)).item1;
    final List<GoalCell> newState = oldState.value!.map((goalCell) {
      if (tasks.contains(goalCell.number)) {
        return GoalCell(
          number: goalCell.number,
          done: goalCell.done,
          checked: true,
        );
      }
      return goalCell;
    }).toList();
    state = AsyncValue.data(newState);
  }

  Future<void> getHeatMapData(Goal goal) async {
    state = const AsyncValue.loading();
    // 範囲をリストに展開
    List<GoalCell> pages = [];
    for (int i = goal.start; i < (goal.last + 1); i++) {
      pages.add(GoalCell(number: i, done: false, checked: false));
    }
    // 入力された記録の範囲
    final List records = await recordRepository.selectRangeItem(
      supabase.auth.currentUser!.id,
      goal.bookId,
      goal.startedAt,
      DateTime.now(),
    );
    for (var item in records) {
      final record = Record.fromJson(item);
      for (int i = record.start; i < (record.last + 1); i++) {
        final GoalCell? searchResult =
            pages.firstWhereOrNull((item) => item.number == i);
        if (searchResult == null) {
          continue;
        }
        int tupleIndex = pages.indexOf(searchResult);
        GoalCell newCellData = GoalCell(
          number: searchResult.number,
          done: true,
          checked: searchResult.checked,
        );
        pages[tupleIndex] = newCellData;
      }
    }
    state = AsyncValue.data(pages);
    checkTodayTask(goal);
  }

  void tapNumber(int number) {
    final List<GoalCell> newstate = state.value!.map((GoalCell item) {
      if (item.number == number) {
        return GoalCell(
            number: number, done: item.done, checked: !item.checked);
      } else {
        return item;
      }
    }).toList();
    state = AsyncValue.data(newstate);
  }
}

class GoalCell {
  int number;
  bool done;
  bool checked;
  GoalCell({required this.number, required this.done, required this.checked});
}
