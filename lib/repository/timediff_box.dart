import 'package:hive/hive.dart';
import 'box_manager.dart';

class TimeDiffBox{
  static const String name = BoxManager.timeDiffBoxName;
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
}