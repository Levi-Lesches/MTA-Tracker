import "package:flutter/material.dart";
import "package:mta/data.dart";

import "route.dart";

class ArrivalTile extends StatelessWidget {
  final MtaArrival arrival;
  const ArrivalTile(this.arrival);

  @override
  Widget build(BuildContext context) => ListTile(
    leading: RouteIcon(arrival.route),
    title: Text(arrival.eta.formatAsEta()),
    subtitle: Text(arrival.direction),
  );
}

class ArrivalsCard extends StatelessWidget {
  final List<MtaArrival> arrivals;
  const ArrivalsCard(this.arrivals);

  String get stopName => arrivals.first.stopName;

  @override
  Widget build(BuildContext context) => Card(
    child: Column(
      children: [
        ListTile(title: Text(stopName)),
        for (final arrival in arrivals) ArrivalTile(arrival),
      ],
    ),
  );
}
