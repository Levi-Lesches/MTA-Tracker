import "utils.dart";
import "route.dart";

class MtaArrival implements Comparable<MtaArrival> {
  final MtaRoute route;
  final String direction;
  final DateTime eta;
  final String stopName;
  final String tripId;
  MtaArrival? toTransfer;

  MtaArrival({
    required this.route,
    required this.direction,
    required this.eta,
    required this.tripId,
    required this.stopName,
  });

  factory MtaArrival.fromJson({
    required MtaRoute route,
    required String direction,
    required Json json,
  }) {
    final stopName = json["stopName"] as String;
    final isRealtime = json["realtime"] as bool;
    final departureDaySeconds = json["serviceDay"] as int;
    final departureDay = DateTime.fromMillisecondsSinceEpoch(departureDaySeconds * 1000);
    final departureOffsetKey = isRealtime ? "realtimeDeparture" : "scheduledDeparture";
    final departureOffset = Duration(seconds: json[departureOffsetKey]);
    final tripId = json["tripId"];
    final eta = departureDay + departureOffset;
    return MtaArrival(
      route: route,
      direction: direction,
      eta: eta,
      stopName: stopName,
      tripId: tripId,
    );
  }

  static List<MtaArrival> forStop(Json json) {
    final route = MtaRoute.fromJson(json.innerJson("route"));
    final direction = json["headsign"];
    return [
      for (final timeJson in json.innerJsonList("times"))
        MtaArrival.fromJson(route: route, direction: direction, json: timeJson),
    ];
  }

  static List<MtaArrival> forTrip(Json json) {
    final tripJson = json.innerJson("trip");
    final route = MtaRoute.fromJson(tripJson.innerJson("route"));
    final direction = tripJson["tripHeadsign"];
    return [
      for (final stopJson in json.innerJsonList("stopTimes"))
        MtaArrival.fromJson(route: route, direction: direction, json: stopJson),
    ];
  }

  @override
  int compareTo(MtaArrival other) => eta.compareTo(other.eta);

  @override
  String toString() =>
      "${route.displayName} to $direction arrives at $stopName at ${eta.formatAsEta()}";
}
