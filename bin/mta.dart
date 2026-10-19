// ignore_for_file: avoid_print

import "package:mta/data.dart";
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
      result.add("${arrival.route.displayName} to ${arrival.direction} arrives at ${arrival.eta.formatAsEta()}");
    }
  }

  print(result.join("\n"));
}
