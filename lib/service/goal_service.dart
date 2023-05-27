import 'package:tuple/tuple.dart';

import '../component/constants.dart';
import '../infrastructure/goal_repository.dart';
import '../infrastructure/record_repository.dart';
import '../model/book_model.dart';
import '../model/goal_model.dart';
import '../model/record_model.dart';

class GoalsService {
  final goalRepository = GoalRepository();
  final recordRepository = RecordRepository();

  Future<void> addItem(Book book, String start, String last, String periodDays,
      String dayratio) async {
    final goal = Goal(
      startedAt: DateTime.now(),
      start: int.parse(start),
      last: int.parse(last),
      day: int.parse(periodDays),
      reflected: false,
      userId: supabase.auth.currentUser!.id,
      bookId: book.id!,
      dayratio: dayratio,
    );
    await goalRepository.createItem(goal);
  }

  Future<void> giveUp(Goal goal) async {
    await goalRepository.deleteItem(goal);
  }

  Future<void> close(Goal goal) async {
    await goalRepository.closeItem(goal);
  }

  Future<Tuple2<List<int>, double>> getTaskInformationFromGoal(
      Goal goal) async {
    // 範囲をリストに展開
    List<int> pages = [];
    for (int i = goal.start; i < (goal.last + 1); i++) {
      pages.add(i);
    }
    final total = pages.length;
    // 前日までに入力された記録の範囲を削除
    final List records = await recordRepository.selectRangeItem(
        supabase.auth.currentUser!.id,
        goal.bookId,
        goal.startedAt,
        DateTime.now().add(const Duration(days: -1)));
    for (var item in records) {
      final record = Record.fromJson(item);
      for (int i = record.start; i < (record.last + 1); i++) {
        if (pages.contains(i)) {
          pages.remove(i);
        }
      }
    }
    // 残りの日数からの推奨ページを計算
    int remainingPages = pages.length;
    final int remainingDays = goal.startedAt
        .add(Duration(days: goal.day))
        .difference(DateTime.now())
        .inDays;
    int reccomendPages = 0;
    if (remainingDays >= 0) {
      reccomendPages = (remainingPages / (remainingDays + 1)).round();
    }
    // 今日に推奨ページ数以上やっていたらタスク完了と表示
    final List todayRecords = await recordRepository.selectTodayItem(
        supabase.auth.currentUser!.id, goal.bookId, DateTime.now());
    final List<int> pagesWithDoneToday = [...pages];
    for (var item in todayRecords) {
      final record = Record.fromJson(item);
      for (int i = record.start; i < (record.last + 1); i++) {
        if (pagesWithDoneToday.contains(i)) {
          pagesWithDoneToday.remove(i);
        }
      }
    }
    remainingPages = pagesWithDoneToday.length;
    // return
    final double percent = 1 - remainingPages / total;
    final done = (pages.length - pagesWithDoneToday.length) >= reccomendPages;
    if (done) {
      return Tuple2([], percent);
    }
    reccomendPages =
        reccomendPages - (pages.length - pagesWithDoneToday.length);
    if (pagesWithDoneToday.length <= reccomendPages) {
      return Tuple2(pagesWithDoneToday, percent);
    }
    return Tuple2(pagesWithDoneToday.sublist(0, reccomendPages), percent);

    // done/notdone, suggestion_pages, percentage
  }
}
