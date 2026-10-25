import "package:flutter/material.dart";
import "package:mta/data.dart";
import "package:mta/widgets.dart";

class ArrivalTile extends StatelessWidget {
  final MtaArrival arrival;
  const ArrivalTile(this.arrival);

  @override
  Widget build(BuildContext context) => ListTile(
    leading: RouteIcon(arrival.route),
    title: Text(arrival.eta.formatAsEta()),
    subtitle: Text(arrival.direction),
    leadingAndTrailingTextStyle: context.textTheme.bodyLarge,
    trailing: arrival.toTransfer == null
        ? Text(context.formatTime(arrival.eta))
        : Text(
            "${context.formatTime(arrival.eta)} - ${context.formatTime(arrival.toTransfer!.eta)}",
          ),
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
