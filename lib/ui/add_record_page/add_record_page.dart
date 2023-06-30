import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/ui/add_record_page/add_record_tab_view.dart';
import 'package:leadstudy/ui/add_record_page/timer_tab_view.dart';
import 'package:leadstudy/view_model/add_record_from_goal_view_model.dart';

import '../../model/book_model.dart';
import '../../model/goal_model.dart';
import 'add_record_from_goal_tab_view.dart';

final startControllerStateProvider =
    StateProvider.autoDispose((ref) => TextEditingController());
final lastControllerStateProvider =
    StateProvider.autoDispose((ref) => TextEditingController());
final durationHoursControllerStateProvider =
    StateProvider.autoDispose((ref) => TextEditingController());
final durationSecondsControllerStateProvider =
    StateProvider.autoDispose((ref) => TextEditingController());
final datetimeStateProvider =
    StateProvider.autoDispose((ref) => DateTime.now());

class AddRecordScreenArgument {
  Goal? goal;
  Book book;
  AddRecordScreenArgument({this.goal, required this.book});
}

class AddRecordPage extends ConsumerStatefulWidget {
  const AddRecordPage(this.argument, {Key? key}) : super(key: key);
  final AddRecordScreenArgument argument;

  @override
  AddRecordPageState createState() => AddRecordPageState();
}

class AddRecordPageState extends ConsumerState<AddRecordPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: (widget.argument.goal == null) ? 0 : 1,
    );
    if (widget.argument.goal == null) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(goalCellsProvider.notifier)
          .getHeatMapData(widget.argument.goal!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("記録の追加"),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  text: "任意記録",
                ),
                Tab(
                  text: "目標から記録",
                ),
                Tab(
                  text: "時間を測定",
                ),
              ],
            ),
          ),
          body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                addRecordTabView(context, ref, widget.argument.book),
                addRecordFromGoalTabView(
                    context, ref, widget.argument.book, widget.argument.goal),
                timerTabView(context, ref, _tabController),
              ]),
        ));
  }
}
