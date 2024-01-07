import 'dart:core';

import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class DateFormatter {
  static const String DATE_FORMAT = "yyyy-MM-dd";
  static const String DATE_TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
  static const String DATE_TIME_FORMAT_2 = "yyyy-MM-dd HH:mm";
  static const String DATE_TIME_FORMAT_3 = "yyyy-MM-dd HH";
  static const String DATE_TIME_FORMAT_4 = "yyyy-MM-dd HH:mm:ss.SSS";
  static const String ONLY_HOUR_MIN="HH:mm";
  static const String ONLY_MONTH_DAY="MM-dd";
  static String formatDuration(Duration duration) {
    int days = duration.inDays;
    int hours = duration.inHours.remainder(24);
    int minutes = duration.inMinutes.remainder(60);
    if(days==0&&hours==0&&minutes==0)return "less than 1 minutes";
    return "${days==0?'':'$days days '}${hours==0?'':'$hours hours '} ${minutes==0?'':'$minutes minutes'}";
  }
  static String format(DateTime date, String format) {
    return DateFormat(format).format(date);
  }
  static int getSecond(int hour,int minute, int second) {
    return hour*3600+minute*60+second;
  }
  static String getTimeStrFromSecond(int second) {
    int hour = second~/3600;
    int minute = (second%3600)~/60;
    int sec = second%60;
    return "${hour<10?"0$hour":hour}:${minute<10?"0$minute":minute}:${sec<10?"0$sec":sec}";
  }
  static String timezoneStrToLocationStr(String timezone) {
    return timezone.replaceFirst('/', ' ');
  }
  static String locationStrToTimezoneStr(String str){
    return str.replaceFirst(' ','/');
  }
}
class NotificationKeyFormattor{
  static String makeKey(int id,NotifOper oper){
    String key='$id:';
    switch(oper){
      case NotifOper.stop:
        key+='0';
        break;
      case NotifOper.start:
        key+='1';
        break;
    }
    return key;
  }
  static Tuple2<int,int>parse(String key){
    int ind=key.indexOf(':');
    int id=int.parse(key.substring(0,ind));
    int oper=int.parse(key.substring(ind+1));
    return Tuple2(id,oper);
  }
}
List<int> alarmKeyParse(String id){
  return  id.split(':').map((value)=>int.parse(value)).toList();
}
enum NotifOper{
  stop,
  start,
}