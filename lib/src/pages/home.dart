import "package:flutter/material.dart";
import "package:mta/src/widgets/atomic/arrivals.dart";

import "package:mta/view_models.dart";
import "package:mta/widgets.dart";

/// The home page.
class HomePage extends ReactiveWidget<HomeModel> {
  @override
  HomeModel createModel() => HomeModel();

  @override
  Widget build(BuildContext context, HomeModel model) => Scaffold(
    appBar: AppBar(title: const Text("MTA Tracker")),
    body: Center(child: Column(children: [for (final stop in model.path) ArrivalsCard(stop)])),
    floatingActionButton: FloatingActionButton(
      onPressed: model.refresh,
      child: const Icon(Icons.refresh),
    ),
  );
}
