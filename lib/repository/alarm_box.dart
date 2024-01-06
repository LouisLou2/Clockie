import 'package:clockie/repository/box_manager.dart';
import 'package:hive/hive.dart';

import '../model/alarm_model.dart';

class AlarmBox {
  static const String name = BoxManager.alarmBoxName;
  static const String availableIdKey = 'alarmAvailableId';
  //这个box这里规定，键值对的键是闹钟name,用户不设置name就用空串，值是闹钟的实例
  static late Box<Alarm> box;
  static bool isBoxOpen() => Hive.isBoxOpen(name);
  static Future<void> closeBox(){
    if(isBoxOpen()) {
      return box.close();
    }
    return Future.value();
  }
  static Future<void> openBox() async{
    if(isBoxOpen()) return;
    box=await Hive.openBox<Alarm>(name);
  }
  static Future<void> openBoxWithoutCheck() async{
    box= await Hive.openBox<Alarm>(name);
  }
}