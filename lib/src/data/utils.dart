/// A JSON object
typedef Json = Map<String, dynamic>;

extension JsonUtils on Json {
  Json innerJson(String key) => (this[key] as Map).cast<String, dynamic>();
  List<Json> innerJsonList(String key) => (this[key] as List).cast<Json>();
}

/// Utils on [Map].
extension MapUtils<K, V> on Map<K, V> {
  /// Gets all the keys and values as 2-element records.
  Iterable<(K, V)> get records => entries.map((entry) => (entry.key, entry.value));
}

/// Zips two lists, like Python
Iterable<(E1, E2)> zip<E1, E2>(List<E1> list1, List<E2> list2) sync* {
  if (list1.length != list2.length) throw ArgumentError("Trying to zip lists of different lengths");
  for (var index = 0; index < list1.length; index++) {
    yield (list1[index], list2[index]);
  }
}

/// Extensions on lists
extension ListUtils<E> on List<E> {
  /// Iterates over a pair of indexes and elements, like Python
  Iterable<(int, E)> get enumerate sync* {
    for (var i = 0; i < length; i++) {
      yield (i, this[i]);
    }
  }
}

extension DateTimeUtils on DateTime {
  DateTime operator +(Duration dur) => add(dur);

  String formatAsEta() {
    final now = DateTime.now();
    final eta = difference(now);
    return "${eta.inMinutes} min";
  }

  DateTime get startOfDay => DateTime(year, month, day);
  int get secondsSinceEpoch => millisecondsSinceEpoch ~/ 1000;
}
