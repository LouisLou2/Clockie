import 'package:clockie/service/provider/alarm_provider.dart';
import 'package:clockie/service/provider/stopwatch_provider.dart';
import 'package:clockie/service/provider/timer_provider.dart';
import 'package:clockie/service/provider/world_clock_provider.dart';

class PenthHouseProviders{
  static AlarmProvider? alarmProvider;
  static WorldClockProvider? worldClockProvider;
  static StopWatchProvider? stopWatchProvider;
  static TimerProvider? timerProvider;
  static init(){
    alarmProvider=AlarmProvider();
    worldClockProvider=WorldClockProvider();
    stopWatchProvider=StopWatchProvider();
    timerProvider=TimerProvider();
  }
}