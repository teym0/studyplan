import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/stream/provider.dart';
import 'package:tuple/tuple.dart';

import '../component/constants.dart';
import '../infrastructure/goal_repository.dart';
import '../infrastructure/record_repository.dart';
import '../model/book_model.dart';
import '../model/goal_model.dart';
import '../model/record_model.dart';

class GoalsService {
  GoalsService(this.ref);

  Ref ref;

  final goalRepository = GoalRepository();
  final recordRepository = RecordRepository();

  Future<void> addItem(Book book, String start, String last, DateTime endDate,
      String dayratio) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    endDate = DateTime(endDate.year, endDate.month, endDate.day);
    print(endDate.difference(today).inDays);
    final goal = Goal(
      startedAt: DateTime.now(),
      start: int.parse(start),
      last: int.parse(last),
      day: endDate.difference(today).inDays + 1,
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

  Map<int, int> _getWeekdayCounts(DateTime startDate, DateTime endDate) {
    startDate =
        DateTime(startDate.year, startDate.month, startDate.day, 0, 0, 0, 0, 0);
    endDate = DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0, 0, 0);
    final Map<int, int> weekdayCounts = {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0,
    };

    for (var date = startDate;
        date.isBefore(endDate) || date.isAtSameMomentAs(endDate);
        date = date.add(const Duration(days: 1))) {
      weekdayCounts[date.weekday] = weekdayCounts[date.weekday]! + 1;
    }

    return weekdayCounts;
  }

  Map<int, int> _extractDayRatioString(String dayratio) {
    final List<String> ratio = dayratio.split('');
    final Map<int, int> weekdayData = {
      for (int index in [1, 2, 3, 4, 5, 6, 7])
        index: int.parse(ratio[index - 1])
    };
    return weekdayData;
  }

  int getTotalRatioUnitCount(
      DateTime startDate, DateTime endDate, String dayratio) {
    final Map<int, int> weekDayCounts = _getWeekdayCounts(startDate, endDate);
    final Map<int, int> dayRatio = _extractDayRatioString(dayratio);
    int totalRatioUnitCount = 0;
    weekDayCounts.forEach((weekday, count) {
      totalRatioUnitCount += count * dayRatio[weekday]!;
    });
    return totalRatioUnitCount;
  }

  int getOriginalRemainingDays(
      DateTime startDate, DateTime endDate, List<int> dayratio) {
    int days = 0;
    final Map<int, int> weekDayCounts = _getWeekdayCounts(startDate, endDate);
    weekDayCounts.forEach((weekday, count) {
      if (dayratio[weekday - 1] != 0) {
        days += count;
      }
    });
    return days;
  }

  Tuple2<List<int>, double> getTaskInformationFromGoal(Goal goal) {
    final recordService = ref.read(recordServiceProvider);
    List<Record>? allRecords = ref.read(recordsProvider).value;
    allRecords ??= [];
    // 範囲をリストに展開
    List<int> pages = [];
    for (int i = goal.start; i < (goal.last + 1); i++) {
      pages.add(i);
    }
    final total = pages.length;
    // 前日までに入力された記録の範囲を削除
    final List<Record> records = recordService.selectRangeItem(
        allRecords,
        goal.bookId,
        goal.startedAt,
        DateTime.now().add(const Duration(days: -1)),
        goal);
    for (Record record in records) {
      for (int i = record.start; i < (record.last + 1); i++) {
        if (pages.contains(i)) {
          pages.remove(i);
        }
      }
    }
    // 残りの日数からの推奨ページを計算
    int remainingPages = pages.length;
    int totalRatioUnitCount = getTotalRatioUnitCount(DateTime.now(),
        goal.startedAt.add(Duration(days: goal.day - 1)), goal.dayratio);
    late int reccomendPages;
    if (totalRatioUnitCount == 0) {
      // 残りの日数すべて比率が0の場合、残りページ/残り日数に設定
      int remainingPages = pages.length;
      final int remainingDays = goal.startedAt
              .add(Duration(days: goal.day))
              .difference(DateTime.now())
              .inDays +
          1;
      if (remainingDays > 0) {
        reccomendPages = (remainingPages / (remainingDays + 1)).round();
      } else {
        reccomendPages = 0;
      }
    } else {
      reccomendPages = ((remainingPages / totalRatioUnitCount) *
              _extractDayRatioString(goal.dayratio)[DateTime.now().weekday]!)
          .round();
    }
    // 今日に推奨ページ数以上やっていたらタスク完了と表示
    final List todayRecords =
        recordService.selectTodayItem(allRecords, goal.bookId, goal);
    final List<int> pagesWithDoneToday = [...pages];
    for (var record in todayRecords) {
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
