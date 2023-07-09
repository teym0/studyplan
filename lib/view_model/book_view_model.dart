import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/infrastructure/book_repository.dart';

import '../model/book_model.dart';

final bookRepositoryProvider = Provider((ref) => BookRepository(ref: ref));

final booksProvider =
    StateNotifierProvider<BookViewModel, AsyncValue<List<Book>>>((ref) {
  final bookRepository = ref.read(bookRepositoryProvider);
  return BookViewModel(bookRepository);
});

class BookViewModel extends StateNotifier<AsyncValue<List<Book>>> {
  BookViewModel(this.bookRepository) : super(const AsyncValue.loading()) {
    initialize();
  }

  BookRepository bookRepository;

  Future<void> initialize() async {
    _reload();
  }

  Future<void> _reload() async {
    final List<Book> books = await bookRepository.selectItems();
    state = AsyncValue.data(books);
  }

  Future<void> delete(Book book) async {
    bookRepository.deleteItem(book);
    _reload();
  }

  Future<void> create(Book book, Uint8List image) async {
    bookRepository.createItem(book, image);
    _reload();
  }

  Future<void> update(Book newBook, Uint8List image) async {
    bookRepository.updateItem(newBook, image);
    _reload();
  }
}
