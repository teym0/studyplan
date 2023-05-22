import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:leadstudy/stream/provider.dart';
import 'package:leadstudy/ui/add_record_page/add_record_page.dart';
import 'package:leadstudy/ui/book_detail_page/create_goal_page.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tuple/tuple.dart';

import '../../model/book_model.dart';
import '../../model/goal_model.dart';

Widget detailTabView(BuildContext context, Book book, List<Goal> goals) {
  Widget goalCard(
      WidgetRef ref, Goal goal, Tuple2<List<int>, double> taskInformation) {
    ref.read(goalsServiceProvider).getTaskInformationFromGoal(goal);
    final int remaining = goal.startedAt
        .add(Duration(days: goal.day))
        .difference(DateTime.now())
        .inDays;
    final int amount = goal.last - goal.start + 1;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: const Color(0xebf0f1ff)),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${goal.start}~${goal.last}",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "($amount)",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoActionSheet(
                                  actions: [
                                    CupertinoActionSheetAction(
                                      child: const Text(
                                        'あきらめる',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () {
                                        ref
                                            .read(goalsServiceProvider)
                                            .giveUp(goal);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                  cancelButton: CupertinoButton(
                                    child: const Text('キャンセル'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.edit)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            "/new_record",
                            arguments:
                                AddRecordScreenArgument(book: book, goal: goal),
                          );
                        },
                        child: const Text("記録"),
                      ),
                    ],
                  ),
                ],
              ),
              (remaining >= 0)
                  ? Text(
                      "残り: $remaining日",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "期間が終了しました。",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          "${DateFormat('yyyy年MM月dd日').format(goal.startedAt)}から${goal.day}日間",
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (remaining >= 0)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (taskInformation.item1.isEmpty)
                                ? const Text("本日分は完了しました!")
                                : Text(
                                    "今日の推奨タスク: ${taskInformation.item1.join(", ")}"),
                          ],
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: LinearPercentIndicator(
                      barRadius: const Radius.circular(10),
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 400,
                      percent: taskInformation.item2,
                      progressColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.all(22.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(00.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 90,
                height: 120,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8.0,
                        offset: const Offset(0, 5)),
                  ],
                ),
                child: (book.imageUrl == null)
                    ? Container()
                    : CachedNetworkImage(
                        imageUrl: book.imageUrl!,
                        fit: BoxFit.contain,
                      ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.book,
                            color: Colors.grey.shade700,
                          ),
                          Text(
                            book.amount.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "目標",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed("/new_goal",
                    arguments: CreateGoalArgument(book));
              },
              icon: const Icon(Icons.add),
              label: const Text("目標を立てる"),
            ),
          ],
        ),
        Consumer(
          builder: (context, ref, child) {
            return Flexible(
              child: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                      future: ref
                          .read(goalsServiceProvider)
                          .getTaskInformationFromGoal(goals[index]),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return goalCard(ref, goals[index], snapshot.data!);
                        }
                        return const Center(child: CircularProgressIndicator());
                      });
                },
              ),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
