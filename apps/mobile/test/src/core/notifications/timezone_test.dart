import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  setUpAll(() {
    tz.initializeTimeZones();
  });

  group('Timezone Behavior', () {
    test('local timezone scheduling shifts UTC time correctly', () {
      final utcTime = DateTime.utc(2026, 1, 1, 12);
      
      // Assume a device in America/New_York (UTC-5 in winter)
      tz.setLocalLocation(tz.getLocation('America/New_York'));
      
      final tzTime = tz.TZDateTime.from(utcTime, tz.local);
      
      // 12:00 UTC is 07:00 EST
      expect(tzTime.hour, 7);
      expect(tzTime.minute, 0);
      expect(tzTime.timeZone.abbreviation, 'EST');
      
      // Assume a device in Asia/Tokyo (UTC+9)
      tz.setLocalLocation(tz.getLocation('Asia/Tokyo'));
      
      final tzTimeTokyo = tz.TZDateTime.from(utcTime, tz.local);
      
      // 12:00 UTC is 21:00 JST
      expect(tzTimeTokyo.hour, 21);
      expect(tzTimeTokyo.minute, 0);
      expect(tzTimeTokyo.timeZone.abbreviation, 'JST');
    });
  });
}
