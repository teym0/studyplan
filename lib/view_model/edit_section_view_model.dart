import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/model/section_model.dart';

final editSectionProvider =
    StateNotifierProvider<EditSectionViewModel, List<Section>>((ref) {
  return EditSectionViewModel();
});

class EditSectionViewModel extends StateNotifier<List<Section>> {
  EditSectionViewModel() : super([]);

  void sortByStartAscending() {
    state = List.from(state)..sort((a, b) => a.start.compareTo(b.start));
  }

  bool checkRangeOverlap(List<Section> sections, Section newSection) {
    for (var section in sections) {
      if (newSection.start <= section.last &&
          newSection.last >= section.start) {
        return true;
      }
    }
    return false;
  }

  bool rangeValidation(Section section) {
    return (section.start < section.last);
  }

  String? addSection(String name, int start, int last) {
    final newSection = Section(name: name, start: start, last: last);
    if (!rangeValidation(newSection)) {
      return "はじめの位置を終わりの位置より後に設定することはできません。";
    }
    if (checkRangeOverlap(state, newSection)) {
      return "範囲が重なっています。";
    }
    if (newSection.last - newSection.start > 300) {
      return "パフォーマンスの都合上、一つのセクションに300以上の割り当てはできません。";
    }
    state = [...state, newSection];
    sortByStartAscending();
    return null;
  }

  void deleteSection(Section section) {
    final newList = state.where((index) => index != section).toList();
    state = newList;
  }

  void setSections(List<Section> sections) {
    state = sections;
  }
}
