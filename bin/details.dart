// ignore_for_file: avoid_print

import "package:mta/data.dart";
import "package:mta/services.dart";

import "my_queries.dart" show myQueries;

typedef ApiQuery = ({List<String> routeNames, String stopName});

/* in my_queries.dart:

import "details.dart";

final myQueries = <ApiQuery>[
  (["A", "B"], "Home Stop"),
  (["A", "B", "X", "Y"], "Central hub"),
  (["X", "Y"], "Work Stop"),
];
*/

void main() async {
  print("");

  final api = MtaApi();
  final routes = await api.getAllRoutes();
  for (final query in myQueries) {
    for (final routeName in query.routeNames) {
      final route = routes.getByName(routeName);
      final routeStops = await api.getStops(route.id);
      final stop = routeStops.getByName(query.stopName);
      final directions = await api.getDirectionNames(stop.id);
      print("Route: ${route.displayName} (${route.id})");
      print("Route: ${stop.name} (${stop.id})");
      print("Directions: $directions");
      print("---------------------------------");
    }
  }
}
