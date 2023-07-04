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
            .inDays +
        1;
    final int amount = goal.last - goal.start + 1;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${goal.start}~${goal.last}",
                        style: const TextStyle(fontSize: 24),
                      ),
                      Text(
                        "($amount)",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  (remaining >= 0)
                      ? Row(
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
                                              style:
                                                  TextStyle(color: Colors.red),
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
                            FilledButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  "/new_record",
                                  arguments: AddRecordScreenArgument(
                                      book: book, goal: goal),
                                );
                              },
                              child: const Text("記録"),
                            ),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () {
                            ref.read(goalsServiceProvider).close(goal);
                          },
                          child: const Text("閉じる")),
                ],
              ),
              (remaining >= 0)
                  ? Container()
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
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text(
                        "残り日数",
                        style: TextStyle(fontSize: 20),
                      ),
                      Row(
                        children: [
                          Text(
                            "$remaining",
                            style: const TextStyle(fontSize: 50),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            "日",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "本日残り",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${taskInformation.item1.length}",
                            style: const TextStyle(
                              fontSize: 50,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            book.unitName,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: LinearPercentIndicator(
                      barRadius: const Radius.circular(10),
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 400,
                      percent: taskInformation.item2,
                      progressColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: Colors.grey.withOpacity(0.4),
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
              SizedBox(
                width: 90,
                height: 120,
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
            final filteredGoals =
                goals.where((goal) => !goal.reflected).toList();
            return Flexible(
              child: ListView.builder(
                itemCount: filteredGoals.length,
                itemBuilder: (context, index) {
                  final data = ref
                      .read(goalsServiceProvider)
                      .getTaskInformationFromGoal(goals[index]);
                  return goalCard(ref, goals[index], data);
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
