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
      return 'Same Time';
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
  static DateTime getFirstInvokeTime(Alarm alarm){
    DateTime now=DateTime.now();
    if(alarm.pickNum==0){
      now=DateTime(now.year,now.month,now.day,alarm.hour,alarm.min);
      if(isTheAlarmShouldInTomorrow(alarm)) {
        now=now.add(const Duration(days: 1));
      }
      return now;
    }
    for(int i=now.weekday-1;i<alarm.pickNum;i=(i+1)%7){
      if(alarm.days[i]){
        now=getFirstInvokeTimeWithWeekday(alarm, i+1);
      }
    }
    return now;
  }
  static DateTime getFirstInvokeTimeWithWeekday(Alarm time,int targetWeekday){
    DateTime nowtime = DateTime.now();
    DateTime aTime = DateTime(nowtime.year, nowtime.month, nowtime.day, time.hour, time.min);
    if(aTime.weekday<targetWeekday||aTime.weekday==targetWeekday&&nowtime.isBefore(aTime)){
      aTime = aTime.add(Duration(days: targetWeekday-aTime.weekday));
      return aTime;
    }
    aTime = aTime.add(Duration(days: 7-aTime.weekday+targetWeekday));
    return aTime;
  }
}