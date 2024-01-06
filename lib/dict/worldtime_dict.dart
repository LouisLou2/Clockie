import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../repository/timediff_box.dart';
class WorldTimeDict{
  static late Map<String,int>timeDiffDict;
  static bool hasInited=false;
  static bool isIniting=false;
  static List<String> get timeDiffDictAsList=>timeDiffDict.keys.toList();
  static int nativeOffset=DateTime.now().timeZoneOffset.inHours;

  static Future<void> init()async {
    if(hasInited||isIniting)return;
    isIniting=true;
    timeDiffDict={};
    //从box中读取
    await TimeDiffBox.openBox();
    if(TimeDiffBox.box.isEmpty){
      updateTimeDiff();
      return;
    }
    timeDiffDict=TimeDiffBox.box.toMap().map((key, value) => MapEntry(key as String, value));
    hasInited=true;
    isIniting=false;
    TimeDiffBox.closeBox();//读取完即自动关闭
  }
  static void updateTimeDiff(){
    timeDiffDict={};
    if(!hasInited){
      tzdata.initializeTimeZones(); // 初始化时区数据库
      hasInited=true;
    }
    DateTime now = DateTime.now();
    Map<String,tz.Location>locationMap=tz.timeZoneDatabase.locations;
    timeDiffDict=locationMap.map((key, loca) => MapEntry(key, calculateDiffForHour(now, loca)));
    //放入box
    TimeDiffBox.openBox();
    TimeDiffBox.box.putAll(timeDiffDict);
  }
  static int calculateDiffForHour(DateTime native ,tz.Location loca){
    //因为DateTime.difference计算时差时会自动转换时区，所以计算不出来，只能用这个办法
    tz.TZDateTime currentTimeInB = tz.TZDateTime.from(native, loca);
    int diff=currentTimeInB.hour-native.hour;
    if(native.day>currentTimeInB.day){
      diff-=24;
    }else if(native.day<currentTimeInB.day){
      diff+=24;
    }
    return diff;
  }
  static int calculateDiffForHourWithStr(DateTime native ,String loca){
    tz.Location locationB = tz.getLocation(loca);
    return calculateDiffForHour(native, locationB);
  }
}