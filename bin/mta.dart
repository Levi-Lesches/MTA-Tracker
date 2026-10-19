// ignore_for_file: avoid_print

import "package:mta/data.dart";
import "package:mta/services.dart";

void main() async {
  final api = MtaApi();
  final routes = await api.getAllRoutes();
  final q = routes.getByName("Q");
  final qStops = await api.getStops(q);
  final atlantic = qStops.getByName("Atlantic");
  final atlanticArrivals = await api.getArrivals(atlantic);
  final qArrivals = atlanticArrivals.getByRoute(q, "Brighton Beach & Coney Island");
  final now = DateTime.now();
  for (final arrival in qArrivals) {
    var sign = "AM";
    var hour = arrival.hour;
    if (hour > 12) {
      hour -= 12;
      sign = "PM";
    }
    final eta = arrival.difference(now);
    print("- $hour:${arrival.minute} $sign (${eta.inMinutes} away)");
  }
}
