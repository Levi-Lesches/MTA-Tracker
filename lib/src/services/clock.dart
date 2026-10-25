import "mta.dart";
import "schedule.dart" show schedule;

typedef ClockInterval = ({int hour, List<MtaQuery> queries, String dest});
typedef Query = ({String stopId, String direction, List<String> routeIds});

/* in schedule.dart:
import "clock.dart";
const Query firstRideToWork = (...)
const Query transferToWork = (...)
const Query firstRideToHome = (...)
const Query transferToHome = (...)

final schedule = <ClockInterval>[
  (hour: lastTimeToGoToWork, queries: [expand(firstRideToWork), transferToWork], dest: "stop name"),
  (hour: lastTimeToGoToHome, queries: [expand(firstRideToHome), transferToHome], dest: "stop name"),
]

// eg,
final schedule = [
  // Until 10am: go uptown to hub, then transfer again uptown
  (hour: 10, queries: [expand(homeStopUptown), expand(hubUptown)]),

  // Until 11pm: go downtown to hub, then transfer again downtown
  (hour: 23, queries: [expand(workStopDowntown), expand(hubDowntown)]),
]
*/

class ClockService {
  ClockInterval getPath(int hour) {
    for (final interval in schedule) {
      if (hour < interval.hour) {
        return interval;
      }
    }
    return schedule.last;
  }
}
