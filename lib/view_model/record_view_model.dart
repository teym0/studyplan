import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/component/constants.dart';
import 'package:leadstudy/infrastructure/record_repository.dart';
import 'package:leadstudy/model/book_model.dart';

import '../model/record_model.dart';

final recordListProvider =
    StateNotifierProvider<RecordListViewModel, AsyncValue<List<Record>>>(
        ((ref) {
  return RecordListViewModel();
}));

final recordRepository = RecordRepository();

class RecordListViewModel extends StateNotifier<AsyncValue<List<Record>>> {
  // RecordListController() : super(const AsyncValue.loading()) {
  //   if (supabase.auth.currentUser != null) {
  //   }
  // }
  RecordListViewModel() : super(const AsyncData([]));

  Future<void> _sortItems() async {
    List<Record> sorted = [...?state.value];
    sorted.sort((b, a) => a.startedAt.compareTo(b.startedAt));
    state = AsyncValue.data(sorted);
  }

  Future<void> addItems(List<Record> records) async {
    for (Record record in records) {
      final newItem = await recordRepository.createItem(record);
      state = AsyncValue.data([...?state.value, newItem]);
    }
    _sortItems();
  }

  Future<void> addItem(Record record) async {
    final newItem = await recordRepository.createItem(record);
    state = AsyncValue.data([...?state.value, newItem]);
    _sortItems();
  }

  Future<void> getRecentActivity(Book book) async {
    state = const AsyncValue.loading();

    final match = {
      "book_id": book.id,
      "user_id": supabase.auth.currentUser!.id
    };
    final List<dynamic> response = await recordRepository.selectItem(match);
    final records = (response).map((item) => Record.fromJson(item)).toList();
    state = AsyncValue.data(records);
    _sortItems();
  }

  Future addRecord(String start, String last, String duration, Book book,
      DateTime startedAt) async {
    final record = Record(
      start: int.parse(start),
      last: int.parse(last),
      duration: int.parse(duration),
      userId: supabase.auth.currentUser!.id,
      bookId: book.id!,
      startedAt: startedAt,
      recordedAt: DateTime.now(),
    );
    addItem(record);
  }

  Future<void> deleteItem(Record deleterecord) async {
    recordRepository.deleteItem(deleterecord);
    state = AsyncValue.data([
      for (final record in [...?state.value])
        if (record.id != deleterecord.id) record,
    ]);
  }
}
