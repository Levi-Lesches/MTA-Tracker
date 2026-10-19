// ignore_for_file: avoid_print

import "package:mta/services.dart";

void main() async {
  print("");

  final result = <String>[];
  final hour = DateTime.now().hour;
  final path = services.clock.getPath(hour);
  for (final stop in path) {
    final arrivals = (await services.mta.getArrivals(stop)).toList();
    arrivals.sort();

    final stopName = arrivals.first.stopName;
    result.add("------ $stopName -----");

    for (final arrival in arrivals) {
      result.add(arrival.toString());
    }
  }

  print(result.join("\n"));
}
