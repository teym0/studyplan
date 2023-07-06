import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/model/book_model.dart';
import 'package:leadstudy/ui/edit_book_page.dart';

import '../view_model/book_view_model.dart';
import '../view_model/section_view_model.dart';
import 'book_detail_page/book_detail_page.dart';

class BooksListPage extends HookConsumerWidget {
  const BooksListPage({super.key});

  Widget bookListView(BuildContext context, WidgetRef ref, List<Book> books) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 5,
        childAspectRatio: 0.7,
      ),
      itemCount: books.length,
      itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            // decoration: BoxDecoration(
            //   border: Border.all(width: 1, color: const Color(0xebf0f1ff)),
            //   borderRadius: BorderRadius.circular(10),
            //   color: Colors.white,
            // ),
            // padding: const EdgeInsets.all(4),
            child: InkWell(
              onTap: (() {
                ref
                    .read(sectionListProvider.notifier)
                    .getSections(books[index]);
                Navigator.of(context).pushNamed(
                  "/book_detail",
                  arguments: BookScreenArgument(books[index]),
                );
              }),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    (books[index].imageUrl == null)
                        ? Container()
                        : Flexible(
                            flex: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: CachedNetworkImage(
                                imageUrl: books[index].imageUrl!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              books[index].title,
                              style: const TextStyle(fontSize: 10),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookList = ref.watch(booksProvider).value ?? [];
    // final List<Book> bookList = [];
    // final bookList = ref.watch(booksListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "教材一覧",
        ),
        actions: [
          IconButton(
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoActionSheet(
                      actions: [
                        CupertinoActionSheetAction(
                          child: const Text('教材を編集'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed("/manage_books");
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('新しい教材を追加'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed("/new_book",
                                arguments: BookEditScreenArgument(null));
                          },
                        ),
                      ],
                      cancelButton: CupertinoButton(
                        child: const Text('キャンセル'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.edit)),
        ],
      ),
      body: bookListView(context, ref, bookList),
    );
  }
}
