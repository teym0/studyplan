import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/component/constants.dart';
import 'package:leadstudy/infrastructure/section_repository.dart';
import 'package:leadstudy/model/book_model.dart';
import 'package:leadstudy/model/section_model.dart';

final sectionListProvider =
    StateNotifierProvider<SectionListViewModel, AsyncValue<List<Section>>>(
        (ref) {
  return SectionListViewModel();
});

final sectionRepository = SectionRepository();

class SectionListViewModel extends StateNotifier<AsyncValue<List<Section>>> {
  SectionListViewModel() : super(const AsyncData([]));

  Future<void> deleteAllItems(int bookId) async {
    await sectionRepository.clearItem(bookId);
    state = const AsyncData([]);
  }

  Future<void> addMultipleItems(List<Section> sections, Book parent) async {
    for (Section section in sections) {
      final section_ = section.copyWith(
          bookId: parent.id, userId: supabase.auth.currentUser!.id);
      addItem(section_);
    }
  }

  Future<void> addItem(Section section) async {
    final newItem =
        await sectionRepository.createItem(section.copyWith(id: null));
    state = AsyncValue.data([...?state.value, newItem]);
  }

  Future<List<Section>> getSections(Book book) async {
    state = const AsyncValue.loading();

    final match = {
      "book_id": book.id,
      "user_id": supabase.auth.currentUser!.id
    };
    final List<dynamic> response = await sectionRepository.selectItem(match);
    final sections = (response).map((item) => Section.fromJson(item)).toList();
    state = AsyncValue.data(sections);
    return sections;
  }
}
