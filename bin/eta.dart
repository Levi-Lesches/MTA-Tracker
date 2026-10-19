// ignore_for_file: avoid_print

import "package:mta/data.dart";
import "package:mta/services.dart";

// Eg, show all arrivals for the Q train at Atlantic Ave, going to Manhattan

void main() async {
  print("");

  final api = MtaApi();
  final routes = await api.getAllRoutes();
  final route = routes.getByName("Q");
  final stops = await api.getStops(route.id);
  final stop = stops.getByName("Atlantic");
  final query = MtaQuery(routeId: route.id, stopId: stop.id, direction: "Manhattan");
  final arrivals = await api.getArrivals(query);

  for (final arrival in arrivals) {
    print(arrival.eta.formatAsEta());
  }
}
