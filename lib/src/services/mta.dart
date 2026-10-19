import "package:http/http.dart" as http;
import "package:mta/data.dart";

import "http.dart";

class MtaApi {
  static const routesUrl = "https://otp-mta-prod.camsys-apps.com/otp/routers/default/index/routes";
  static final routesUri = Uri.parse(routesUrl);
  // static const routesApiKey = "Z276E3rCeTzOQEoBPPN4JCEc6GfvdnYE";

  static const stopsUrl = "https://collector-otp-prod.camsys-apps.com/schedule/MTASBWY/stopsForRoute";
  static final stopsUri = Uri.parse(stopsUrl);
  // static const stopsApiKey = "qeqy84JE7hUKfaI0Lxm2Ttcm6ZA0bYrP";

  static const arrivalsUrl = "https://otp-mta-prod.camsys-apps.com/otp/routers/default/nearby";
  static final arrivalsUri = Uri.parse(arrivalsUrl);
  // static const arrivalsApiKey = "Z276E3rCeTzOQEoBPPN4JCEc6GfvdnYE";

  Future<Iterable<MtaRoute>> getAllRoutes() async {
    final url = routesUri.replace();
    final response = await http.get(url);
    response.throwHttpError("Could not GET routes");
    return response.toJsonList().map(MtaRoute.fromJson);
  }

  Future<Iterable<MtaStop>> getStops(MtaRoute route) async {
    final url = stopsUri.replace(queryParameters: {"routeId": route.id});
    final response = await http.get(url);
    response.throwHttpError("Could not GET stops");
    return response.toJsonList().map(MtaStop.fromJson);
  }

  Future<Iterable<MtaArrival>> getArrivals(MtaStop stop) async {
    final url = arrivalsUri.replace(queryParameters: {"stops": stop.id});
    final response = await http.get(url);
    response.throwHttpError("Could not GET arrivals");
    final stopJson = response.toJsonList()[0];
    final groups = stopJson.innerJsonList("groups");
    return [
      for (final group in groups) ...MtaArrival.fromJson(group),
    ];
  }
}
