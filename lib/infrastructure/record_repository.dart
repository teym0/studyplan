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

  Future<void> deleteItem(Record record) async {
    await supabase.from("records").delete().match(record.toJson());
  }
}
