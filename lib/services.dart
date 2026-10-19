/// Defines and manages the different services used by the app.
library;

export "src/services/service.dart";
export "src/services/mta.dart";
export "src/services/clock.dart";

import "";

/// A [Service] that manages all other services used by the app.
class Services extends Service {
	/// Prevents other instances of this class from being created.
	Services._();

  // Define your services here
  final mta = MtaApi();
  final clock = ClockService();

	/// The different services to initialize, in this order.
	List<Service> get services => [];

	@override
	Future<void> init() async {
		for (final service in services) {
      await service.init();
    }
	}
}

/// The global services object.
final services = Services._();
