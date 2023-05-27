import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/component/constants.dart';
import 'package:leadstudy/stream/provider.dart';

import '../../model/book_model.dart';

final goalRatioBoardProvider = StateProvider<List<int>>((ref) {
  return [1, 1, 1, 1, 1, 1, 1];
});

class CreateGoalArgument {
  Book book;
  CreateGoalArgument(this.book);
}

class CreateGoalPage extends ConsumerStatefulWidget {
  const CreateGoalPage({super.key, required this.args});
  final CreateGoalArgument args;

  @override
  ConsumerState<CreateGoalPage> createState() => _CreateGoalPageState();
}

class _CreateGoalPageState extends ConsumerState<CreateGoalPage> {
  final startController = TextEditingController();
  final lastController = TextEditingController();
  final periodDaysController = TextEditingController();

  Widget goalRatioBoardCell(
      int weeknumber, int number, List<int> goalRatioBoardData) {
    final checked = number <= goalRatioBoardData[weeknumber];
    return GestureDetector(
      onTap: () {
        if (number == goalRatioBoardData[weeknumber]) {
          goalRatioBoardData[weeknumber] = 0;
        } else {
          goalRatioBoardData[weeknumber] = number;
        }
        ref.read(goalRatioBoardProvider.notifier).state = [
          ...goalRatioBoardData
        ];
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: (checked)
                ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
                : Theme.of(context).colorScheme.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  Widget goalRatioBoardLine(
      int weeknumber, String dayoftheweek, List<int> goalRatioBoardData) {
    return Column(
      children: [
        goalRatioBoardCell(weeknumber, 8, goalRatioBoardData),
        goalRatioBoardCell(weeknumber, 7, goalRatioBoardData),
        goalRatioBoardCell(weeknumber, 6, goalRatioBoardData),
        goalRatioBoardCell(weeknumber, 5, goalRatioBoardData),
        goalRatioBoardCell(weeknumber, 4, goalRatioBoardData),
        goalRatioBoardCell(weeknumber, 3, goalRatioBoardData),
        goalRatioBoardCell(weeknumber, 2, goalRatioBoardData),
        goalRatioBoardCell(weeknumber, 1, goalRatioBoardData),
        Text(dayoftheweek),
      ],
    );
  }

  Widget goalRatioBoard() {
    final goalRatioBoardData = ref.watch(goalRatioBoardProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            goalRatioBoardLine(0, "Mon", goalRatioBoardData),
            goalRatioBoardLine(1, "Tue", goalRatioBoardData),
            goalRatioBoardLine(2, "Wed", goalRatioBoardData),
            goalRatioBoardLine(3, "Thu", goalRatioBoardData),
            goalRatioBoardLine(4, "Fri", goalRatioBoardData),
            goalRatioBoardLine(5, "Sat", goalRatioBoardData),
            goalRatioBoardLine(6, "Sun", goalRatioBoardData),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("目標を立てる"),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.numbers),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              controller: startController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(5),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "開始",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "〜",
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Flexible(
                            child: TextField(
                              controller: lastController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(5),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "終了",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.timer_outlined),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: periodDaysController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "期間(日)",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                goalRatioBoard(),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton.icon(
                      onPressed: () {
                        final goalRatioBoard = ref.read(goalRatioBoardProvider);
                        if (goalRatioBoard.every((element) => element == 0)) {
                          context.showErrorSnackBar(
                              message: "最低1日は比率を1以上に指定してください。");
                          return;
                        }
                        ref.read(goalsServiceProvider).addItem(
                              widget.args.book,
                              startController.text,
                              lastController.text,
                              periodDaysController.text,
                              goalRatioBoard.join().toString(),
                            );
                        Navigator.of(context).pop();
                      },
                      label: const Text("設定する"),
                      icon: const Icon(Icons.save_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
