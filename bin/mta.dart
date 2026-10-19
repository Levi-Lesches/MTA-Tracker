// ignore_for_file: avoid_print

import "package:mta/data.dart";
import "package:mta/services.dart";

void main() async {
  print("");

  final result = <String>[];
  final hour = DateTime.now().hour;
  final path = services.clock.getPath(hour);
  for (final stop in path) {
    final arrivals = <MtaArrival>[];
    for (final query in stop) {
      final arrivalsForRoute = await services.mta.getArrivals(query);
      arrivals.addAll(arrivalsForRoute);
    }
    arrivals.sort();

    final stopName = arrivals.first.stopName;
    result.add("------ $stopName -----");

    for (final arrival in arrivals) {
      result.add("${arrival.route.displayName} arrives at ${arrival.eta.formatAsEta()}");
    }
  }

  print(result.join("\n"));
}