import "dart:async";

import "package:collection/collection.dart";

import "package:mta/data.dart";
import "package:mta/services.dart";

import "view_model.dart";

/// The view model for the home page.
class HomeModel extends ViewModel {
  List<List<MtaArrival>> path = [];

  List<String> get stops => [for (final arrivals in path) arrivals.first.stopName];

  Future<void> refresh() async {
    final hour = DateTime.now().hour;
    final result = <List<MtaArrival>>[];
    final schedule = services.clock.getPath(hour);
    for (final stop in schedule) {
      final arrivals = (await services.mta.getArrivals(stop)).toList();
      arrivals.sort();
      result.add(arrivals);
    }
    path = result;
    notifyListeners();

    for (final (index, stop) in path.indexed) {
      final nextIndex = index + 1;
      if (nextIndex == stops.length) continue;
      final nextStopName = stops[nextIndex];
      for (final trip in stop) {
        final tripEtas = await services.mta.getArrivalsForTrip(trip.tripId);
        final eta = tripEtas.firstWhereOrNull((other) => other.stopName == nextStopName);
        trip.toTransfer = eta;
      }
    }
    notifyListeners();
  }

  Timer? _refreshTimer;

  HomeModel() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (_) => refresh());
    refresh();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }
}
