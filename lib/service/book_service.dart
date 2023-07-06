import 'package:image_picker/image_picker.dart';
import 'package:leadstudy/infrastructure/book_repository.dart';
import 'package:leadstudy/model/book_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final bookRepository = BookRepository();

class BooksService {
  Future<Book> addItem(Book book) async {
    final newItem = await bookRepository.createItem(book);
    return newItem;
  }

  Future<void> deleteItem(Book deletebook) async {
    await bookRepository.deleteItem(deletebook);
  }

  Future<Book> editItem(Book targetBook, Book afterBook) async {
    final Book newBook_ =
        await bookRepository.updateItem(targetBook, afterBook);
    return newBook_;
  }

  Future<Book> editBook(Book targetBook, String title, String amount,
      String unitName, String pendingAvatarUrl) async {
    final newBook = Book(
      title: title,
      userId: -1,
      amount: int.parse(amount),
      unitName: unitName,
      imageUrl: pendingAvatarUrl,
      createdAt: DateTime.now(),
    );
    return editItem(targetBook, newBook);
  }

  Future<Book> addBook(String title, String amount, String unitName,
      String pendingAvatarUrl) async {
    final book = Book(
      title: title,
      userId: -1,
      amount: int.parse(amount),
      unitName: unitName,
      imageUrl: pendingAvatarUrl,
      createdAt: DateTime.now(),
    );
    return addItem(book);
  }

  Future<String> uploadImage(XFile pickedFile) async {
    final bytes = await pickedFile.readAsBytes();
    final fileExt = pickedFile.path.split('.').last;
    final filePath = '${DateTime.now().toIso8601String()}.$fileExt';
    final fileOptions = FileOptions(contentType: pickedFile.mimeType);
    final imageUrl = bookRepository.uploadImage(filePath, bytes, fileOptions);
    return imageUrl;
  }

  Future<void> deleteImage(String publicUrl) async {
    final String filePath = Uri.parse(publicUrl).pathSegments.last;
    bookRepository.deleteImage(filePath);
  }
}
