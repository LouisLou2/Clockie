import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:clockie/service/alarm_isolate_handler.dart';
import 'package:clockie/dict/worldtime_dict.dart';
import 'package:clockie/model/adapter/alarm_adapter.dart';
import 'package:clockie/repository/alarm_box.dart';
import 'package:clockie/repository/chosen_city_box.dart';
import 'package:clockie/repository/setting_box.dart';
import 'package:clockie/repository/timediff_box.dart';
import 'package:clockie/service/alarm_manager.dart';
import 'package:clockie/service/navigation/navigator_manager.dart';
import 'package:clockie/service/notification/notification_service.dart';
import 'package:clockie/service/provider/penthhouse_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

Future<void>initMustBeforeRunApp()async {
  initBasicUI();
  NavigatorManager.init();
  PenthHouseProviders.init();
  AlarmIsolateHandler.init();
  await Hive.initFlutter();
  Hive.registerAdapter(AlarmAdapter());
  await SettingBox.openBox();
  AlarmManager.initAvailableId();
  PenthHouseProviders.themeProvider!.init();
}
Future<void> initNormally() async{
  AlarmBox.openBox();
  PenthHouseProviders.alarmProvider?.initData();
  TimeDiffBox.openBox();
  WorldTimeDict.init();
  ChosenCityBox.openBox();
  PenthHouseProviders.worldClockProvider?.initData();
  initNotification();
}
Future<void> initDatabase() async{}

void initBasicUI(){
  //目前是多余的
  // SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(
  //         //systemStatusBarContrastEnforced: true,
  //         //statusBarColor: Colors.green,
  //         //statusBarIconBrightness: Brightness.dark,
  //         systemNavigationBarColor: Colors.transparent,
  //         systemNavigationBarIconBrightness: Brightness.dark,
  //         systemNavigationBarDividerColor: Colors.transparent,
  //     )
  // );
}
Future<void> initNotification() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await NotificationService.initializeNotification();
}