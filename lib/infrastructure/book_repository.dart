import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:leadstudy/component/constants.dart';
import 'package:leadstudy/model/book_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookRepository {
  Future<List<Book>> selectItems(String token) async {
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final res = await http.get(Uri.parse("http://127.0.0.1:7000/api/v1/books/"),
        headers: headers);
    final List body = jsonDecode(res.body);
    final List<Book> books = body.map((book) => Book.fromJson(book)).toList();
    return books;
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
