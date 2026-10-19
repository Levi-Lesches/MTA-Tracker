import "package:meta/meta.dart";
import "utils.dart";

@immutable
class MtaStop {
  final String id;
  final String name;

  MtaStop.fromJson(Json json) :
    id = json["stopId"],
    name = json["stopName"];

  @override
  bool operator ==(Object other) => other is MtaStop && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

extension IterMtaStopUtils on Iterable<MtaStop> {
  MtaStop getByName(String name) => firstWhere((stop) => stop.name.contains(name));
}

extension IterIterMtaStopUtils on Iterable<Iterable<MtaStop>> {
  List<MtaStop> getByName(String name) => [
    for (final stopsList in this)
      stopsList.getByName(name),
  ];
}
