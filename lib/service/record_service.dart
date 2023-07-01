import 'package:leadstudy/component/constants.dart';
import 'package:leadstudy/infrastructure/record_repository.dart';
import 'package:leadstudy/model/book_model.dart';
import 'package:leadstudy/model/goal_model.dart';

import '../model/record_model.dart';

final recordRepository = RecordRepository();

class RecordService {
  Future<void> addItems(List<Record> records) async {
    for (Record record in records) {
      await recordRepository.createItem(record);
    }
  }

  Future<void> addItem(Record record) async {
    await recordRepository.createItem(record);
  }

  Future addRecord(String start, String last, int duration, Book book,
      DateTime startedAt, Goal? goal) async {
    final record = Record(
      start: int.parse(start),
      last: int.parse(last),
      duration: duration,
      userId: supabase.auth.currentUser!.id,
      bookId: book.id!,
      startedAt: startedAt,
      recordedAt: DateTime.now(),
      goalId: goal?.id,
    );
    addItem(record);
  }

  Future<void> deleteItem(Record deleterecord) async {
    recordRepository.deleteItem(deleterecord);
  }

  List selectTodayItem(List<Record> records, int? bookId, Goal? goal) {
    final today = DateTime.now();
    final start = DateTime(today.year, today.month, today.day, 0, 0, 0).toUtc();
    final last =
        DateTime(today.year, today.month, today.day, 23, 59, 59).toUtc();
    return selectRangeItem(records, bookId, start, last, goal);
  }

  bool _isDateTimeInRange(
      DateTime dateTime, DateTime startDateTime, DateTime endDateTime) {
    return dateTime.isAfter(startDateTime) && dateTime.isBefore(endDateTime);
  }

  List<Record> selectRangeItem(List<Record> records, int? bookId,
      DateTime start, DateTime last, Goal? goal) {
    start = DateTime(start.year, start.month, start.day, 0, 0, 0).toUtc();
    last = DateTime(last.year, last.month, last.day, 23, 59, 59).toUtc();
    return records.where((Record record) {
      return (_isDateTimeInRange(record.startedAt, start, last) &&
          (bookId == null || record.bookId == bookId) &&
          (goal?.id == record.goalId || goal == null));
    }).toList();
  }
}
