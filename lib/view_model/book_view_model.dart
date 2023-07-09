import 'dart:io';
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
    await bookRepository.deleteItem(book);
    await _reload();
  }

  Future<void> create(Book book, File image) async {
    final imageBytes = await image.readAsBytes();
    await bookRepository.createItem(book, imageBytes);
    await _reload();
  }

  Future<void> update(Book newBook, File? image) async {
    Uint8List? imageBytes;
    if (image != null) {
      imageBytes = await image.readAsBytes();
    }
    await bookRepository.updateItem(newBook, imageBytes);
    await _reload();
  }
}
