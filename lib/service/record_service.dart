import 'package:leadstudy/component/constants.dart';
import 'package:leadstudy/infrastructure/record_repository.dart';

import '../model/record_model.dart';

final recordRepository = RecordRepository();

class RecordService {
  Future<int> getTodayHour() async {
    int totalMinutes = 0;
    final items = await recordRepository.selectTodayItem(
        supabase.auth.currentUser!.id, null, DateTime.now());
    for (var item in items) {
      totalMinutes += Record.fromJson(item).duration;
    }
    return totalMinutes;
  }
}
