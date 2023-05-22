import 'package:leadstudy/component/constants.dart';
import 'package:leadstudy/model/record_model.dart';

class RecordRepository {
  Future<Record> createItem(Record record) async {
    final List response =
        await supabase.from("records").insert(record).select();
    final newRecord = Record.fromJson(response[0]);
    return newRecord;
  }

  Future<List<dynamic>> selectItem(Map<String, dynamic> match) async {
    final List<dynamic> response = await supabase
        .from("records")
        .select()
        .match(match)
        .order('recorded_at', ascending: false);
    return response;
  }

  Future<List> selectTodayItem(
      String userId, int? bookId, DateTime today) async {
    Map<String, dynamic> match = {"user_id": userId, "book_id": bookId};
    if (bookId == null) {
      match = {"user_id": userId};
    }
    final start = DateTime(today.year, today.month, today.day, 0, 0, 0).toUtc();
    final last =
        DateTime(today.year, today.month, today.day, 23, 59, 59).toUtc();
    final List<dynamic> response = await supabase
        .from("records")
        .select()
        .match(match)
        .gte("started_at", start)
        .lte("started_at", last)
        .order('started_at', ascending: false);
    return response;
  }

  Future<List> selectRangeItem(
      String userId, int bookId, DateTime start, DateTime last) async {
    start = DateTime(start.year, start.month, start.day, 0, 0, 0).toUtc();
    last = DateTime(last.year, last.month, last.day, 23, 59, 59).toUtc();
    final List<dynamic> response = await supabase
        .from("records")
        .select()
        .match({"user_id": userId, "book_id": bookId})
        .gte("started_at", start)
        .lte("started_at", last)
        .order('started_at', ascending: false);
    return response;
  }

  Future<void> deleteItem(Record record) async {
    await supabase.from("records").delete().match(record.toJson());
  }
}
