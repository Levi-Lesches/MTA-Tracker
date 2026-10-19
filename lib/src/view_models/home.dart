import "dart:async";

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
    final path = services.clock.getPath(hour);
    for (final stop in path) {
      final arrivals = (await services.mta.getArrivals(stop)).toList();
      arrivals.sort();
      result.add(arrivals);
    }
    this.path = result;
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
