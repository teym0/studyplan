import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/service/book_service.dart';
import 'package:leadstudy/service/goal_service.dart';

import '../component/constants.dart';
import '../model/book_model.dart';
import '../model/goal_model.dart';

final booksProvider = StreamProvider<List<Book>>(
  (ref) => supabase.from('books').stream(primaryKey: ['id']).map(
      (event) => event.map((e) => Book.fromJson(e)).toList()),
);

final goalsProvider = StreamProvider<List<Goal>>(
  (ref) => supabase.from('goals').stream(primaryKey: ['id']).map(
      (event) => event.map((e) => Goal.fromJson(e)).toList()),
);

final booksServiceProvider = Provider((ref) => BooksService());
final goalsServiceProvider = Provider((ref) => GoalsService());
