import "package:flutter/material.dart";
import "package:mta/data.dart";
import "package:mta/widgets.dart";

extension on MtaRoute {
  Color get color => Color(0xff000000 | hexColor);
}

class RouteIcon extends StatelessWidget {
  final MtaRoute route;
  const RouteIcon(this.route);

  Color get textColor => switch (ThemeData.estimateBrightnessForColor(route.color)) {
    .dark => Colors.white,
    .light => Colors.black,
  };

  @override
  Widget build(BuildContext context) => CircleAvatar(
    backgroundColor: route.color,
    child: Text(
      route.displayName,
      style: context.textTheme.titleLarge?.copyWith(color: textColor, fontWeight: .bold),
    ),
  );
}
