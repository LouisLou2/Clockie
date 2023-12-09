import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:clockie/model/alarm_model.dart';
import 'package:clockie/model/base_time.dart';
import 'package:tuple/tuple.dart';

import 'alarm_isolate_handler.dart';
import '../repository/setting_box.dart';

class AlarmManager{
  static int _idAvailable = -1;
  static DateTime nowtime = DateTime.now();
  static Map<String,String> defaultAlarmParams = {'name':'Time\'s up!','desc':'No Further Description'};
  static void upadateNowTime() {
    nowtime = DateTime.now();
  }
  static initAvailableId() async{
    _idAvailable=await SettingBox.getAvailableId();
  }
  static int _getAvailableId(){
    if(_idAvailable==-1)throw Exception('AlarmManager: _idAvailable is not initialized');
    return _idAvailable++;
  }
  static List<Tuple2<int,int>> _batchGetId(List<bool>days){
    List<Tuple2<int,int>> ids=[];
    for(int i=0;i<days.length;++i){
      if(days[i])ids.add(Tuple2(i+1, _getAvailableId()));
    }
    return ids;
  }
  static DateTime _getFirstInvokeTime(HourMin time) {
    upadateNowTime();
    DateTime invoketime = DateTime(nowtime.year, nowtime.month, nowtime.day, time.hour, time.min);
    if(invoketime.isBefore(DateTime.now())) {
      invoketime = invoketime.add(const Duration(days: 1));
    }
    return invoketime;
  }

  static DateTime _nextWeekdayOfTime(HourMin time,int targetWeekday){
    upadateNowTime();
    DateTime targetTime = DateTime(nowtime.year, nowtime.month, nowtime.day, time.hour, time.min);
    if(targetTime.weekday<targetWeekday){
      targetTime = targetTime.add(Duration(days: targetWeekday-targetTime.weekday));
      return targetTime;
    }
    targetTime = targetTime.add(Duration(days: 7-(targetTime.weekday-targetWeekday)));
    return targetTime;
  }

  static Future<String> smartSetAlarm(Alarm alarm, Function doThingsWhenInvoke) async{
    if(_idAvailable==-1)await initAvailableId();
    int singleId=-1;
    Map<String,dynamic>aparams={'name':alarm.name,'desc':alarm.desc,'portName':AlarmIsolateHandler.portName};
    if(alarm.pickNum==0){
      singleId=await _setAlarmTimeOnce(HourMin(alarm.hour, alarm.min), doThingsWhenInvoke,aparams);
      return singleId.toString();
    }
    else if(alarm.pickNum==7){
      singleId=await _setAlarmTimeEveryDay(HourMin(alarm.hour, alarm.min), doThingsWhenInvoke,aparams);
      return singleId.toString();
    }
    else{
      StringBuffer buf=StringBuffer();
      final List<Tuple2<int,int>>ids=_batchGetId(alarm.days);
      buf.write(ids[0].item2);
      _setAlarmTimeDayOfWeek(ids[0].item2, HourMin(alarm.hour,alarm.min), ids[0].item1, doThingsWhenInvoke, aparams);
      for(int i=1;i<ids.length;++i){
        buf.write(':${ids[i].item2}');
        _setAlarmTimeDayOfWeek(ids[i].item2, HourMin(alarm.hour,alarm.min), ids[i].item1, doThingsWhenInvoke, aparams);
      }
      return buf.toString();
    }
  }
  static Future<int> _setAlarmTimeOnce(HourMin time, Function doThingsWhenInvoke,Map<String, dynamic>?aparams) async {
    aparams ??= Map.from(defaultAlarmParams);
    aparams['isOnce']=true;
    int id=_getAvailableId();
    aparams['id']=id.toString();
    AndroidAlarmManager.oneShotAt(_getFirstInvokeTime(time), id, doThingsWhenInvoke,
        exact: true,
        wakeup: true,
        alarmClock: true,
        allowWhileIdle: true,
        rescheduleOnReboot: true,
        params: aparams,
    );
    return id;
  }
  static Future<int>_setAlarmTimeEveryDay(HourMin time, Function doThingsWhenInvoke,Map<String, dynamic>?aparams) async {
    int id=_getAvailableId();
    aparams ??= Map.from(defaultAlarmParams);
    aparams['id']=id.toString();
    //依据time,是每天的time
    AndroidAlarmManager.periodic(
      const Duration(days: 1), // 间隔为1天，每天触发一次
      _getAvailableId(),
      doThingsWhenInvoke, // 替换为实际的闹钟触发时执行的方法
      startAt: _getFirstInvokeTime(time), // 设置起始时间为今天的8点
      exact: true,
      wakeup: true,
      allowWhileIdle: true,
      rescheduleOnReboot: true,
      params: aparams,
    );
    return id;
  }
  static Future<int>_setAlarmTimeDayOfWeek(int id,HourMin time, int weekday,Function doThingsWhenInvoke,Map<String, dynamic>?aparams) async {
    aparams ??= Map.from(defaultAlarmParams);
    aparams['id']=id.toString();
    //依据time,是每周的time
    AndroidAlarmManager.periodic(
      const Duration(days: 7), // 间隔为7天，每周触发一次
      id,
      doThingsWhenInvoke, // 替换为实际的闹钟触发时执行的方法
      startAt: _nextWeekdayOfTime(time, weekday),// 设置起始时间为今天的8点
      exact: true,
      wakeup: true,
      allowWhileIdle: true,
      rescheduleOnReboot: true,
      params: aparams,
    );
    return id;
  }
  static void cancelAlarm(int id) async {
    await AndroidAlarmManager.cancel(id);
  }
}