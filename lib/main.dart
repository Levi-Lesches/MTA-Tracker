import "package:flutter/material.dart";

import "package:mta/models.dart";
import "package:mta/pages.dart";
import "package:mta/services.dart";

Future<void> main() async {
  await services.init();
  await models.init();
  await models.initFromOthers();
  runApp(const MtaApp());
}

/// The main app widget.
class MtaApp extends StatelessWidget {
  /// A const constructor.
  const MtaApp();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: "Flutter Demo",
    theme: ThemeData(
      useMaterial3: true,
    ),
    routerConfig: router,
  );
}
