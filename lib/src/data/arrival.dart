import "utils.dart";
import "route.dart";



class MtaArrival {
  final MtaRoute route;
  final String direction;
  final DateTime eta;

  MtaArrival(this.route, this.direction, this.eta);

  static List<MtaArrival> fromJson(Json json) {
    final route = MtaRoute.fromJson(json.innerJson("route"));
    final direction = json["headsign"];
    final results = <MtaArrival>[];
    for (final timeJson in json.innerJsonList("times")) {
      final isRealtime = timeJson["realtime"] as bool;
      final departureDaySeconds = timeJson["serviceDay"] as int;
      final departureDay = DateTime.fromMillisecondsSinceEpoch(departureDaySeconds * 1000);
      final departureOffsetKey = isRealtime ? "realtimeDeparture" : "scheduledDeparture";
      final departureOffset = Duration(seconds: timeJson[departureOffsetKey]);
      final eta = departureDay + departureOffset;
      final arrival = MtaArrival(route, direction, eta);
      results.add(arrival);
    }
    return results;
  }
}

extension IterMtaArrivalsUtils on Iterable<MtaArrival> {
  Iterable<DateTime> filter(MtaRoute route, String direction) => [
    for (final other in this)
      if (other.route == route && other.direction == direction)
        other.eta,
  ];
}
