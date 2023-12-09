import 'dart:core';

class AlarmOneShotOption{
  bool alarmClock = false;
  bool allowWhileIdle = false;
  bool exact = false;
  bool wakeup = false;
  bool rescheduleOnReboot = false;
  Map<String, dynamic> params = const {};
}
class AlarmPeriodicOption{
  DateTime? startAt;
  bool allowWhileIdle = false;
  bool exact = false;
  bool wakeup = false;
  bool rescheduleOnReboot = false;
  Map<String, dynamic> params = const {};
}