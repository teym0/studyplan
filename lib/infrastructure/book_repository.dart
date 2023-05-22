import 'dart:typed_data';

import 'package:leadstudy/component/constants.dart';
import 'package:leadstudy/model/book_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookRepository {
  Future<List<Book>> selectItem() async {
    final result = await supabase.from("books").select();
    final List<Book> books =
        result.map((book) => Book.fromJson(book)).toList().cast<Book>();
    final filtered = books
        .where((book) => book.userId == supabase.auth.currentUser!.id)
        .toList();
    return filtered;
  }

  Future<Book> createItem(Book book) async {
    List response = await supabase.from("books").insert(book).select();
    final newBook = Book.fromJson(response[0]);
    return newBook;
  }

  Future<void> deleteItem(Book book) async {
    await supabase.from("books").delete().match(book.toJson());
  }

  Future<Book> updateItem(Book beforeBook, Book afterBook) async {
    final response = await supabase
        .from("books")
        .update(afterBook.toJson())
        .eq('id', beforeBook.id)
        .select();
    final Book newBook = Book.fromJson(response[0]);
    return newBook;
  }

  Future<String> uploadImage(
      String filePath, Uint8List bytes, FileOptions fileOptions) async {
    await supabase.storage.from('bookimages').uploadBinary(
          filePath,
          bytes,
          fileOptions: fileOptions,
        );
    final imageUrlResponse = await supabase.storage
        .from('bookimages')
        .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10);
    return imageUrlResponse;
  }

  Future<void> deleteImage(String filePath) async {
    await supabase.storage.from('bookimages').remove([filePath]);
  }
}
