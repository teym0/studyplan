import 'dart:convert';
import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:leadstudy/component/constants.dart';
import 'package:leadstudy/model/book_model.dart';
import 'package:leadstudy/view_model/auth_view_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookRepository {
  BookRepository({required this.ref});

  Ref ref;

  Future<List<Book>> selectItems() async {
    final token = ref.read(authProvider).value!.access;
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final res = await http.get(Uri.parse("http://127.0.0.1:7000/api/v1/books/"),
        headers: headers);
    final responseBody = utf8.decode(res.bodyBytes);
    final List body = jsonDecode(responseBody);
    print(body);
    final List<Book> books = body.map((book) => Book.fromJson(book)).toList();
    return books;
  }

  Future<void> createItem(Book book, Uint8List imagebytes) async {
    final token = ref.read(authProvider).value!.access;
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final uri = Uri.parse("http://127.0.0.1:7000/api/v1/books/");
    final request = http.MultipartRequest(
      "POST",
      uri,
    );
    final multipartFile =
        http.MultipartFile.fromBytes('image', imagebytes, filename: "test.jpg");
    request.files.add(multipartFile);
    request.headers.addAll(headers);
    book.toJson().forEach((k, v) => request.fields[k] = v.toString());
    final stream = await request.send();
    http.Response.fromStream(stream).then((response) {
      if (response.statusCode == 200) {
        print(response);
      }

      print(utf8.decode(response.bodyBytes));
    });
  }

  Future<void> updateItem(Book newBook, Uint8List imagebytes) async {
    print(newBook.id);
    final token = ref.read(authProvider).value!.access;
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final uri = Uri.parse("http://127.0.0.1:7000/api/v1/books/${newBook.id}/");
    final request = http.MultipartRequest(
      "PUT",
      uri,
    );
    final multipartFile =
        http.MultipartFile.fromBytes('image', imagebytes, filename: "test.jpg");
    request.files.add(multipartFile);
    request.headers.addAll(headers);
    newBook.toJson().forEach((k, v) => request.fields[k] = v.toString());
    final stream = await request.send();
    http.Response.fromStream(stream).then((response) {
      if (response.statusCode == 200) {
        print(response);
      }

      print(utf8.decode(response.bodyBytes));
    });
  }

  Future<void> deleteItem(Book book) async {
    final token = ref.read(authProvider).value!.access;
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final res = await http.delete(
        Uri.parse("http://127.0.0.1:7000/api/v1/books/${book.id}/"),
        headers: headers);
    print(res.body);
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
