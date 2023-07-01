import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/stream/provider.dart';

import '../component/constants.dart';
import '../infrastructure/record_repository.dart';
import '../model/book_model.dart';
import '../model/goal_model.dart';
import '../model/record_model.dart';

final goalCellsProvider =
    StateNotifierProvider<GoalCellsViewModel, List<GoalCell>>((ref) {
  return GoalCellsViewModel(ref);
});

class GoalCellsViewModel extends StateNotifier<List<GoalCell>> {
  GoalCellsViewModel(this.ref) : super([]);

  final Ref ref;

  final recordRepository = RecordRepository();

  List<Record> getCheckedRecords(Book book, int duration, Goal goal) {
    List<GoalCell> checked =
        state.where((goalcell) => goalcell.checked).toList();
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
          goalId: goal.id,
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
    state = state
        .map((goalCell) => GoalCell(
            number: goalCell.number, done: goalCell.done, checked: false))
        .toList();
  }

  void checkTodayTask(Goal goal) {
    final oldState = state;
    final List<int> tasks =
        ref.read(goalsServiceProvider).getTaskInformationFromGoal(goal).item1;
    final List<GoalCell> newState = oldState.map((goalCell) {
      if (tasks.contains(goalCell.number)) {
        return GoalCell(
          number: goalCell.number,
          done: goalCell.done,
          checked: true,
        );
      }
      return goalCell;
    }).toList();
    state = newState;
  }

  void getHeatMapData(Goal goal) {
    final allRecords = ref.read(recordsProvider).value!;
    // 範囲をリストに展開
    List<GoalCell> pages = [];
    for (int i = goal.start; i < (goal.last + 1); i++) {
      pages.add(GoalCell(number: i, done: false, checked: false));
    }
    // 入力された記録の範囲
    final List records = ref.read(recordServiceProvider).selectRangeItem(
          allRecords,
          goal.bookId,
          goal.startedAt,
          goal.startedAt.add(Duration(days: goal.day)),
          goal,
        );
    for (var record in records) {
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
    state = pages;
    checkTodayTask(goal);
  }

  void tapNumber(int number) {
    final List<GoalCell> newstate = state.map((GoalCell item) {
      if (item.number == number) {
        return GoalCell(
            number: number, done: item.done, checked: !item.checked);
      } else {
        return item;
      }
    }).toList();
    state = newstate;
  }
}

class GoalCell {
  int number;
  bool done;
  bool checked;
  GoalCell({required this.number, required this.done, required this.checked});
}
