import 'package:clockie/service/provider/alarm_provider.dart';
import 'package:clockie/service/provider/resource_provider.dart';
import 'package:clockie/service/provider/settings_provider.dart';
import 'package:clockie/service/provider/stopwatch_provider.dart';
import 'package:clockie/service/provider/timer_provider.dart';
import 'package:clockie/service/provider/world_clock_provider.dart';

import 'theme_provider.dart';

class PenthHouseProviders{
  static AlarmProvider? alarmProvider;
  static WorldClockProvider? worldClockProvider;
  static StopWatchProvider? stopWatchProvider;
  static TimerProvider? timerProvider;
  static ThemeProvider? themeProvider;
  static ResourceProvider?resourceProvider;
  static SettingsProvider? settingsProvider;
  static init(){
    alarmProvider=AlarmProvider();
    worldClockProvider=WorldClockProvider();
    stopWatchProvider=StopWatchProvider();
    timerProvider=TimerProvider();
    themeProvider=ThemeProvider();
    resourceProvider=ResourceProvider();
    settingsProvider=SettingsProvider();
  }
}