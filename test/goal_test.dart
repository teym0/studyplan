import 'package:flutter_test/flutter_test.dart';
import 'package:leadstudy/service/goal_service.dart';

void main() {
  final goalService = GoalsService();
  test("Count total cell", () {
    expect(
      goalService.getTotalRatioUnitCount(
          DateTime(2023, 5, 27), DateTime(2023, 5, 28), "1111111"),
      2,
    );
    expect(
      goalService.getTotalRatioUnitCount(
          DateTime(2023, 5, 27), DateTime(2023, 5, 28), "1111132"),
      5,
    );
    expect(
      goalService.getTotalRatioUnitCount(
          DateTime(2023, 5, 27), DateTime(2023, 6, 2), "1111132"),
      10,
    );
    expect(
      goalService.getTotalRatioUnitCount(
          DateTime(2023, 5, 27), DateTime(2023, 6, 2), "1111132"),
      10,
    );
    expect(
      goalService.getTotalRatioUnitCount(
          DateTime(2023, 5, 27, 12), DateTime(2023, 6, 9), "1111132"),
      20,
    );
  });
}
