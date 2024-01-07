import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:clockie/model/alarm_model.dart';
import 'package:clockie/util/time_util.dart';
import 'package:tuple/tuple.dart';

import 'alarm_isolate_handler.dart';
import '../repository/setting_box.dart';
///在此类中有一个upadateNowTime()方法，因为一个方法可能有几处都会用到现在的时间，
///我不想每次都DateTime.now()，所以我一个方法只更新一次，我相信这一个方法应该不会有太大的时间跨度，所以应该可行
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
    SettingBox.box.put(SettingBox.availableIdKey, _idAvailable+1);
    return _idAvailable++;
  }
  //返回的元组的第一个元素是weekday，第二个元素是id
  static List<Tuple2<int,int>> _batchGetId(List<bool>days){
    List<Tuple2<int,int>> ids=[];
    for(int i=0;i<days.length;++i){
      if(days[i])ids.add(Tuple2(i+1, _getAvailableId()));
    }
    return ids;
  }
  static List<Tuple2<int,int>> _findBelong(Alarm alarm){
    List<int> ids=alarm.id.split(':').map((e) => int.parse(e)).toList();
    List<Tuple2<int,int>> idAndWeekdays=[];
    int j=0;
    for(int i=0;i<alarm.days.length;++i){
      if(alarm.days[i])idAndWeekdays.add(Tuple2(i+1, ids[j++]));//这里的i+1是weekday
    }
    return idAndWeekdays;
  }

  static Future<String> smartSetAlarm(Alarm alarm, Function doThingsWhenInvoke) async{
    if(_idAvailable==-1)await initAvailableId();
    int singleId=-1;
    Map<String,dynamic>aparams=getStanderedParam(alarm);

    if(alarm.pickNum==0){
      singleId=await _setAlarmTimeOnce(alarm, doThingsWhenInvoke,aparams);
      return singleId.toString();
    }
    else{
      StringBuffer buf=StringBuffer();
      final List<Tuple2<int,int>>ids=_batchGetId(alarm.days);

      if(ids.isNotEmpty)buf.write(ids[0].item2);
      for(int i=1;i<ids.length;++i){
        buf.write(':${ids[i].item2}');
      }
      String unitId=buf.toString();
      alarm.id=unitId;
      for(int i=0;i<ids.length;++i){
        setAlarmForLoop(id:ids[i].item2, unitId: unitId, alarm:alarm, time: TimeUtil.getFirstInvokeTimeWithWeekday(alarm,ids[i].item1), doThingsWhenInvoke: doThingsWhenInvoke, aparams: aparams);
      }
      return unitId;
    }
  }
  static Future<void> smartSetAlarmWithExistingId(Alarm alarm, Function doThingsWhenInvoke) async{
    Map<String,dynamic>aparams=getStanderedParam(alarm);
    if(alarm.pickNum==0){
      _setAlarmTimeOnceWithExistingId(int.parse(alarm.id),alarm, doThingsWhenInvoke,aparams);
    }
    else{
      final List<Tuple2<int,int>>ids=_findBelong(alarm);

      for(int i=0;i<ids.length;++i){
        setAlarmForLoop(id:ids[i].item2, unitId: alarm.id, alarm:alarm, time: TimeUtil.getFirstInvokeTimeWithWeekday(alarm,ids[i].item1), doThingsWhenInvoke: doThingsWhenInvoke, aparams: aparams);
      }
    }
  }
  static Future<int> _setAlarmTimeOnce(Alarm time, Function doThingsWhenInvoke,Map<String, dynamic>?aparams) async {
    aparams ??= Map.from(defaultAlarmParams);
    aparams['isOnce']=true;
    int id=_getAvailableId();
    aparams['id']=id.toString();
    AndroidAlarmManager.oneShotAt(TimeUtil.getFirstInvokeTime(time), id, doThingsWhenInvoke,
        exact: true,
        wakeup: true,
        alarmClock: true,
        allowWhileIdle: true,
        rescheduleOnReboot: true,
        params: aparams,
    );
    return id;
  }
  static Future<void> _setAlarmTimeOnceWithExistingId(int id,Alarm time, Function doThingsWhenInvoke,Map<String, dynamic>?aparams) async {
    aparams ??= Map.from(defaultAlarmParams);
    aparams['isOnce']=true;
    aparams['id']=id.toString();
    AndroidAlarmManager.oneShotAt(TimeUtil.getFirstInvokeTime(time), id, doThingsWhenInvoke,
      exact: true,
      wakeup: true,
      alarmClock: true,
      allowWhileIdle: true,
      rescheduleOnReboot: true,
      params: aparams,
    );
  }
  //这个方法专门给循环设置闹钟用的，而且他完全不能用于单次闹钟，两个方法的实现细节也是不一样的
  static void setAlarmForLoop({required int id,required String unitId,Alarm? alarm, required DateTime time, required Function doThingsWhenInvoke,Map<String, dynamic>?aparams}) async {
    if(aparams==null){
      if(alarm==null) {
        aparams=Map.from(defaultAlarmParams);
      } else {
        aparams=getStanderedParam(alarm);
      }
    }
    aparams['isOnce']=false;
    aparams['id']=unitId;
    aparams['uniqueId']=id;
    AndroidAlarmManager.oneShotAt(time, id, doThingsWhenInvoke,
      exact: true,
      wakeup: true,
      alarmClock: true,
      allowWhileIdle: true,
      rescheduleOnReboot: true,
      params: aparams,
    );
  }
  static void cancelAlarm(int id) async {
    await AndroidAlarmManager.cancel(id);
  }
  static Map<String,dynamic>getStanderedParam(Alarm alarm){
    return {'name':alarm.name,'desc':alarm.desc,'portName':AlarmIsolateHandler.portName};
  }
}