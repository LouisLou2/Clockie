import 'package:clockie/dict/worldtime_dict.dart';
import 'package:clockie/util/formattor.dart';

import '../model/alarm_model.dart';

class TimeUtil{
  static String getHourMinStr(String timezone){
    DateTime that=DateTime.now().add(Duration(hours:WorldTimeDict.timeDiffDict[timezone]!));
    return DateFormatter.format(that, DateFormatter.ONLY_HOUR_MIN);
  }
  static String getNativeDateStr(){
    return DateFormatter.format(DateTime.now(), DateFormatter.DATE_FORMAT);
  }
  static String getMonthDayStr(String timezone){
    DateTime that=DateTime.now().add(Duration(hours:WorldTimeDict.timeDiffDict[timezone]!));
    return DateFormatter.format(that, DateFormatter.ONLY_MONTH_DAY);
  }
  static String getDiffStr(String timezone){
    int diff=WorldTimeDict.timeDiffDict[timezone]!;
    if(diff!=0){
      return '${diff.abs()} Hours ${diff>0?'Ahead':'Behind'}';
    }
    else {
      return 'same time';
    }
  }
  static getGMTStr(String timezone){
    int diff=WorldTimeDict.timeDiffDict[timezone]!;
    int offset=WorldTimeDict.nativeOffset+diff;
    return 'GMT${offset.isNegative?'$offset':'+$offset'}:00';
  }

  //时区代号格式并不完全一样，有一个/的，有两个/的，有的没有/
  static String lastItem(String timezone){
    return timezone.substring(timezone.lastIndexOf('/')+1);
  }
  static String strExceptLastItem(String timezone){
    int index=timezone.lastIndexOf('/');
    if(index==-1){
      return timezone;
    }
    return timezone.substring(0,index);
  }
  static bool isTheAlarmShouldInTomorrow(Alarm alarm){
    DateTime now=DateTime.now();
    return now.hour>alarm.hour||(now.hour==alarm.hour&&now.minute>=alarm.min);
  }
  static void equipMeanTime(Alarm alarm){
    DateTime now=DateTime.now();
    if(isTheAlarmShouldInTomorrow(alarm)) {
      now=DateTime(now.year,now.month,now.day,alarm.hour,alarm.min);
      //说明此闹钟应在明天
      alarm.meantTime=DateFormatter.format(now.add(const Duration(days:1)), DateFormatter.DATE_TIME_FORMAT);
    }else{
      now=DateTime(now.year,now.month,now.day,alarm.hour,alarm.min);
      alarm.meantTime=DateFormatter.format(now, DateFormatter.DATE_TIME_FORMAT);
    }
  }
}