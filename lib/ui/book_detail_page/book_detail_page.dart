import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/model/book_model.dart';
import 'package:leadstudy/stream/provider.dart';
import 'package:leadstudy/ui/add_record_page/add_record_page.dart';
import 'package:leadstudy/ui/book_detail_page/detail_tab_view.dart';
import 'package:leadstudy/ui/book_detail_page/history_tab_view.dart';
import 'package:leadstudy/view_model/record_view_model.dart';

import '../../view_model/section_view_model.dart';
import 'heat_map_tab_view.dart';

class BookScreenArgument {
  Book book;
  BookScreenArgument(this.book);
}

class BookDetailPage extends HookConsumerWidget {
  final BookScreenArgument argument;
  const BookDetailPage(this.argument, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final records = ref.watch(recordListProvider);
    final sections = ref.watch(sectionListProvider);
    final goals = ref.watch(goalsProvider.select((goals) => (goals.value ?? [])
        .where((goal) => goal.bookId == argument.book.id)
        .toList()));

    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(argument.book.title),
          elevation: 0,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: "ヒートマップ",
              ),
              Tab(
                text: "情報",
              ),
              Tab(
                text: "履歴",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            heatMapTabView(context, ref, argument.book, records, sections),
            detailTabView(context, argument.book, goals),
            historyTabView(records, argument.book, ref),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              "/new_record",
              arguments: AddRecordScreenArgument(book: argument.book),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
