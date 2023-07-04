import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:leadstudy/model/book_model.dart';
import 'package:leadstudy/model/record_model.dart';
import 'package:leadstudy/stream/provider.dart';

import '../../model/goal_model.dart';

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

Widget recordTabView(BuildContext context, AsyncValue<List<Record>> records,
    Book book, WidgetRef ref) {
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

Widget goalTabView(BuildContext context, List<Goal> goals, WidgetRef ref) {
  final filteredGoals = goals.where((goal) => goal.reflected).toList();
  return ListView.builder(
    itemCount: filteredGoals.length,
    itemBuilder: ((context, index) {
      final goal = filteredGoals[index];
      return Card(
        child: ListTile(
          title: Text(
            "${goal.start}~${goal.last}",
          ),
          subtitle: Text(
              "${DateFormat('yyyy年MM月dd日').format(goal.startedAt)} から ${goal.day}日間"),
        ),
      );
    }),
  );
}

Widget historyTabView(BuildContext context, AsyncValue<List<Record>> records,
    Book book, List<Goal> goals, WidgetRef ref) {
  return DefaultTabController(
    length: 2,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: const TabBar(tabs: [
            Tab(text: "記録"),
            Tab(text: "目標"),
          ]),
        ),
        Flexible(
          //Add this to give height
          child: TabBarView(children: [
            recordTabView(context, records, book, ref),
            goalTabView(context, goals, ref),
          ]),
        ),
      ],
    ),
  );
}
