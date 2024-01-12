import 'package:hive/hive.dart';

import '../dict/theme_enum.dart';
import 'box_manager.dart';

class SettingBox {
  static const String name = BoxManager.settingBoxName;
  static const String availableIdKey = 'alarmAvailableId';
  static const String themeCodeKey = 'themeCode';
  static const String skippingHolidaysKey = 'skippingHolidays';
  static const String ringtoneDurationKey = 'ringtoneDuration';
  static const String vibrateKey = 'vibrate';
  static const String upcomingNotificationKey = 'upcomingNotification';
  static const String ringtoneChosenKey="ringtone";

  static late Box<int> box;
  // 检查指定名称的 Hive 数据盒子是否已经打开
  static bool isBoxOpen() => Hive.isBoxOpen(name);

  // 关闭已经打开的 Hive 数据盒子
  static Future<void> closeBox() async {
    if (isBoxOpen()) {
      box.close();
    }
  }

  // 异步打开 Hive 数据盒子
  static Future<void> openBox() async {
    if (isBoxOpen()) return;
    box = await Hive.openBox<int>(name);
  }

  // 异步打开 Hive 数据盒子，无需检查是否已经打开
  static Future<void> openBoxWithoutCheck() async {
    box = await Hive.openBox<int>(name);
  }

  // 获取可用的 ID
  static Future<int> getAvailableId() async {
    // 如果数据盒子没有打开，尝试打开它
    if (!isBoxOpen()) await openBoxWithoutCheck();
    // 尝试从 Hive 数据盒子中获取可用 ID
    int? wrappedId = box.get(availableIdKey);
    if (wrappedId == null) {
      // 如果没有可用 ID，将其设置为 0 并存储到数据盒子中
      wrappedId = 0;
      box.put(availableIdKey, wrappedId);
      return wrappedId;
    }
    return wrappedId;
  }
  //以下方法用来存储各种设置数据，有些设置数据用户可见，有些用户不可见
  //确保使用此方法时已经打开了box
  static Future<void> setAvailableId(int id) async{
    box.put(availableIdKey, id);
  }
  static Future<void> setThemeCode(int code) async{
    box.put(themeCodeKey, code);
  }
  static int getThemeCode(){
    return box.get(themeCodeKey)??ThemeEnum.light.index;
  }
  static Future<void> setSkippingHolidays(bool skipping) async{
    box.put(skippingHolidaysKey, skipping?1:0);
  }
  static bool getSkippingHolidays(){
    int? value=box.get(skippingHolidaysKey);
    if(value==null){
      setSkippingHolidays(false);
      return false;
    }
    return value==1;
  }
  static int? getRingtoneDuration() {
    return box.get(
      ringtoneDurationKey,
      defaultValue: 1,
    );
  }
  static void setRingtoneDuration(int duration) {
    box.put(ringtoneDurationKey, duration);
  }
  static bool getVibrate() {
    int value=box.get(vibrateKey)??0;
    return value==1;
  }
  static bool getUpcomingNotification() {
    int value=box.get(upcomingNotificationKey)??0;
    return value==1;
  }
  static void setVibrate(bool vibrate) {
    box.put(vibrateKey, vibrate?1:0);
  }
  static void setUpcomingNotification(bool upcomingNotification) {
    box.put(upcomingNotificationKey, upcomingNotification?1:0);
  }
  static int? getRingtoneChosen(){
    return box.get(
      ringtoneChosenKey,
      defaultValue: 0,
    );
  }
  static void setRingtoneChosen(int index){
    box.put(ringtoneChosenKey,index);
  }
}