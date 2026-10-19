import "package:meta/meta.dart";
import "utils.dart";

@immutable
class MtaRoute {
  final int hexColor;
  final String id;
  final String displayName;

  MtaRoute.fromJson(Json json) :
    id = json["id"],
    displayName = json["shortName"] ?? "N/A",
    hexColor = int.parse(json["color"], radix: 16);

  @override
  bool operator ==(Object other) => other is MtaRoute && other.id == id;

  @override
  int get hashCode => id.hashCode;
}


extension IterMtaRouteUtils on Iterable<MtaRoute> {
  MtaRoute getByName(String displayName) => firstWhere((route) => route.displayName == displayName);
}
