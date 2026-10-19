import "package:flutter/material.dart";
import "package:mta/data.dart";

extension on MtaRoute {
  Color get color => Color(0xff000000 | hexColor);
}

class RouteIcon extends StatelessWidget {
  final MtaRoute route;
  const RouteIcon(this.route);

  @override
  Widget build(BuildContext context) => CircleAvatar(
    backgroundColor: route.color,
    child: Text(route.displayName),
  );
}
