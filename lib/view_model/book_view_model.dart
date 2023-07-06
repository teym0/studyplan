import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/infrastructure/book_repository.dart';
import 'package:leadstudy/view_model/auth_view_model.dart';

import '../model/book_model.dart';

final bookRepositoryProvider = Provider((ref) => BookRepository());

final booksProvider =
    StateNotifierProvider<BookViewModel, AsyncValue<List<Book>>>((ref) {
  return BookViewModel(ref);
});

class BookViewModel extends StateNotifier<AsyncValue<List<Book>>> {
  BookViewModel(this.ref) : super(const AsyncValue.loading()) {
    initialize();
  }

  Ref ref;

  Future<void> initialize() async {
    print("initialize");
    final userdata = ref.watch(authProvider);
    if (userdata.hasValue) {
      final List<Book> books = await ref
          .read(bookRepositoryProvider)
          .selectItems(userdata.value!.access);
      state = AsyncValue.data(books);
    }
  }
}
