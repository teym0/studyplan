import 'package:leadstudy/component/constants.dart';
import 'package:leadstudy/infrastructure/record_repository.dart';
import 'package:leadstudy/model/book_model.dart';

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

  // Future<void> getRecentActivity(Book book) async {
  //   final match = {
  //     "book_id": book.id,
  //     "user_id": supabase.auth.currentUser!.id
  //   };
  //   await recordRepository.selectItem(match);
  // }

  Future addRecord(String start, String last, int duration, Book book,
      DateTime startedAt) async {
    final record = Record(
      start: int.parse(start),
      last: int.parse(last),
      duration: duration,
      userId: supabase.auth.currentUser!.id,
      bookId: book.id!,
      startedAt: startedAt,
      recordedAt: DateTime.now(),
    );
    addItem(record);
  }

  Future<void> deleteItem(Record deleterecord) async {
    recordRepository.deleteItem(deleterecord);
  }
}
