import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:leadstudy/model/book_model.dart';
import 'package:leadstudy/model/record_model.dart';
import 'package:leadstudy/stream/provider.dart';

Widget activityLogCard(
    BuildContext context, Book book, Record record, WidgetRef ref) {
  final averageMin =
      (record.duration / (record.last - record.start + 1)).round();
  return Card(
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Theme.of(context).colorScheme.outline,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
    ),
    elevation: 0,
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${record.start} から ${record.last} ${book.unitName}",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 5,
              ),
              Text("${record.duration}分 (平均: $averageMin分/${book.unitName})"),
              const SizedBox(
                height: 10,
              ),
              Text(
                DateFormat('yyyy年MM月dd日 kk時mm分').format(record.startedAt),
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              ref.read(recordServiceProvider).deleteItem(record);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget historyTabView(
    AsyncValue<List<Record>> records, Book book, WidgetRef ref) {
  return records.when(
    data: ((data) {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: activityLogCard(context, book, data[index], ref),
          );
        }),
      );
    }),
    error: ((error, stackTrace) => const Text("Error")),
    loading: (() => const Center(
          child: CircularProgressIndicator(),
        )),
  );
}
