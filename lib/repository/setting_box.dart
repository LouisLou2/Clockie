import 'package:hive/hive.dart';

import 'box_manager.dart';

class SettingBox {
  static const String name = BoxManager.settingBoxName;
  static const String availableIdKey = 'alarmAvailableId';
  //这个box这里规定，键值对的键是闹钟name,用户不设置name就用空串，值是闹钟的实例
  static late Box<int> box;
  static bool isBoxOpen() => Hive.isBoxOpen(name);
  static Future<void> closeBox(){
    if(isBoxOpen()) {
      return box.close();
    }
    return Future.value();
  }
  static Future<void> openBox() async{
    if(isBoxOpen()) return;
    box=await Hive.openBox<int>(name);
  }
  static Future<void> openBoxWithoutCheck() async{
    box= await Hive.openBox<int>(name);
  }
  static Future<int> getAvailableId()async{
    if(!isBoxOpen()) await openBoxWithoutCheck();
    int? wrappedId=box.get(availableIdKey);
    if(wrappedId==null) {
      wrappedId=0;
      box.put(availableIdKey,wrappedId);
      return 0;
    }
    return wrappedId;
  }
}