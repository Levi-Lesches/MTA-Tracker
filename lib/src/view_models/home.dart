import "package:mta/data.dart";
import "package:mta/services.dart";

import "view_model.dart";

/// The view model for the home page.
class HomeModel extends ViewModel {
  void refresh() async {
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
      print("------ $stopName -----");
      for (final arrival in arrivals) {
        result.add("${arrival.route.displayName} arrives at ${arrival.eta.formatAsEta()}");
      }
    }
  }

  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }
}
