import "utils.dart";
import "route.dart";

class MtaArrival implements Comparable<MtaArrival> {
  final MtaRoute route;
  final String direction;
  final DateTime eta;
  final String stopName;

  MtaArrival(this.route, this.direction, this.eta, this.stopName);

  static List<MtaArrival> fromJson(Json json) {
    final route = MtaRoute.fromJson(json.innerJson("route"));
    final direction = json["headsign"];
    final results = <MtaArrival>[];
    for (final timeJson in json.innerJsonList("times")) {
      final stopName = timeJson["stopName"] as String;
      final isRealtime = timeJson["realtime"] as bool;
      final departureDaySeconds = timeJson["serviceDay"] as int;
      final departureDay = DateTime.fromMillisecondsSinceEpoch(departureDaySeconds * 1000);
      final departureOffsetKey = isRealtime ? "realtimeDeparture" : "scheduledDeparture";
      final departureOffset = Duration(seconds: timeJson[departureOffsetKey]);
      final eta = departureDay + departureOffset;
      final arrival = MtaArrival(route, direction, eta, stopName);
      results.add(arrival);
    }
    return results;
  }

  @override
  int compareTo(MtaArrival other) => eta.compareTo(other.eta);
}
