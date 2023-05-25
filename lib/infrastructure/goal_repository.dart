import 'package:leadstudy/component/constants.dart';
import 'package:leadstudy/model/goal_model.dart';

class GoalRepository {
  Future<Goal> createItem(Goal goal) async {
    final List response = await supabase.from("goals").insert(goal).select();
    final newItem = Goal.fromJson(response[0]);
    return newItem;
  }

  Future<List<dynamic>> selectItem(Map<String, dynamic> match) async {
    final List<dynamic> response =
        await supabase.from("goals").select().match(match);
    return response;
  }

  Future<void> deleteItem(Goal goal) async {
    await supabase.from("goals").delete().match(goal.toJson());
  }

  Future<void> closeItem(Goal goal) async {
    Goal newGoal = goal.copyWith(reflected: true);
    await supabase.from("goals").upsert(newGoal);
  }
}
