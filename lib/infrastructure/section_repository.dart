import 'package:leadstudy/component/constants.dart';
import 'package:leadstudy/model/section_model.dart';

class SectionRepository {
  Future<Section> createItem(Section section) async {
    final List response =
        await supabase.from("sections").insert(section).select();
    final newSection = Section.fromJson(response[0]);
    return newSection;
  }

  Future<List<dynamic>> selectItem(Map<String, dynamic> match) async {
    final List<dynamic> response = await supabase
        .from("sections")
        .select()
        .match(match)
        .order('start', ascending: true);
    return response;
  }

  Future<void> deleteItem(Section section) async {
    await supabase.from("sections").delete().match(section.toJson());
  }

  Future<void> clearItem(int bookId) async {
    await supabase.from("sections").delete().eq("book_id", bookId);
  }
}
