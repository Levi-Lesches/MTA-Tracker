// ignore_for_file: avoid_print

import "package:mta/services.dart";

// Be sure to fill in schedule.dart according to instructions in clock.dart

const hours = [6, 7, 8, 15, 17, 18, 20];

void main() {
  final clock = ClockService();
  for (final hour in hours) {
    final path = clock.getPath(hour);
    print("At $hour: ");
    for (final stop in path) {
      for (final query in stop) {
        print("- $query");
      }
      print("----------------------");
    }
  }
}
