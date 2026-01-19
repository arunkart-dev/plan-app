import 'package:timezone/data/latest.dart' as tz;

class TimezoneService {
  static void init() {
    tz.initializeTimeZones();
  }
}
