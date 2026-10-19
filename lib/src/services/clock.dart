import "mta.dart";
import "schedule.dart" show schedule;

typedef ClockInterval = ({int hour, List<List<MtaQuery>> queries});
typedef Query = ({String stopId, String direction, List<String> routeIds});

List<MtaQuery> expand(Query query) => [
  for (final routeId in query.routeIds)
    MtaQuery(stopId: query.stopId, routeId: routeId, direction: query.direction),
];

/* in schedule.dart:
import "clock.dart";
const Query firstRideToWork = (...)
const Query transferToWork = (...)
const Query firstRideToHome = (...)
const Query transferToHome = (...)

final schedule = <ClockInterval>[
  (hour: lastTimeToGoToWork, queries: [expand(firstRideToWork), transferToWork]),
  (hour: lastTimeToGoToHome, queries: [expand(firstRideToHome), transferToHome]),
]

// eg,
final schedule = [
  // Until 10am: go uptown to hub, then transfer again uptown
  (hour: 10, queries: [expand(homeStopUptown), expand(hubUptown)]),

  // Until 11pm: go downtown to hub, then transfer again downtown
  (hour: 23, queries: [expand(workStopDowntown), expand(hubDowntown)]),
]
*/

// List of stops, each stop is a list of trains that stop there
typedef TransitPath = List<List<MtaQuery>>;

class ClockService {
  TransitPath getPath(int hour) {
    for (final interval in schedule) {
      if (hour < interval.hour) {
        return interval.queries;
      }
    } return schedule.last.queries;
  }
}
