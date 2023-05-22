import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/model/book_model.dart';
import 'package:leadstudy/stream/provider.dart';
import 'package:leadstudy/ui/edit_book_page.dart';

class BooksManagePage extends HookConsumerWidget {
  const BooksManagePage({super.key});

  Widget bookListView(BuildContext context, List<Book> books, WidgetRef ref) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            onTap: () {
              Navigator.of(context).pushNamed("/new_book",
                  arguments: BookEditScreenArgument(books[index]));
            },
            title: Text(books[index].title),
            leading: const Icon(Icons.book),
            trailing: IconButton(
                onPressed: () async {
                  await showCupertinoDialog(
                      context: context,
                      builder: ((context) {
                        return CupertinoAlertDialog(
                          title: Text("${books[index].title} の削除"),
                          content: const Text(
                              "この教材を完全に削除します。操作の取り消しはできません。本当に削除しますか。"),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text("いいえ"),
                              onPressed: () => Navigator.pop(context),
                            ),
                            CupertinoDialogAction(
                              isDestructiveAction: true,
                              onPressed: () async {
                                Navigator.pop(context);
                                await ref
                                    .read(booksServiceProvider)
                                    .deleteItem(books[index]);
                              },
                              child: const Text("削除"),
                            ),
                          ],
                        );
                      }));
                },
                icon: const Icon(Icons.delete)),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookList = ref.watch(booksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("教材を管理"),
      ),
      body: bookList.when(
        data: ((data) {
          return bookListView(context, data, ref);
        }),
        error: ((error, stackTrace) => const Text("Error")),
        loading: (() => const CircularProgressIndicator()),
      ),
    );
  }
}
