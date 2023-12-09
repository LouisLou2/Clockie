import 'package:clockie/repository/alarm_box.dart';
import 'package:clockie/service/invoke_handler.dart';
import 'package:clockie/util/formattor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/alarm_model.dart';
import '../../util/time_util.dart';
import '../alarm_manager.dart';

class AlarmProvider extends ChangeNotifier {
  Alarm alarmNowSetting = Alarm.active();
  //Map<String,Alarm>alarmMap={};
  get alarmList=>AlarmBox.box.values.toList(growable: false);
  bool dataInited=false;
  bool get isDataInited => dataInited;
  int get alarmNum => AlarmBox.box.length;
  bool isInitingData=false;//是否正在初始化数据，引入这个变量是因为由于异步的原因，initData()可能会被多次调用，所以只调用一次

  Alarm getAlarm(String id) {
    return AlarmBox.box.get(id)!;
  }
  void pickDay(int index) {
    alarmNowSetting.changeDay(index);
    notifyListeners();
  }
  void filterActiveState(){
    DateTime now=DateTime.now();
    DateFormat formatter=DateFormat(DateFormatter.DATE_TIME_FORMAT);
    DateTime? that;
    for(var entry in AlarmBox.box.toMap().entries) {
      if(entry.value.pickNum!=0)continue;
      that=formatter.parse(entry.value.meantTime);
      if(that.isAfter(now))continue;
      entry.value.isActive=false;
      AlarmBox.box.put(entry.key, entry.value);
    }
  }
  void setNowAlarmNameAndDesc(String alarmName,String desc) {
    alarmNowSetting.name = alarmName;
    alarmNowSetting.desc = desc;
  }
  void submitAlarm() async {
    bool isOnce=alarmNowSetting.pickNum==0;
    if(isOnce) {
      DateTime now=DateTime.now();
      if(TimeUtil.isTheAlarmShouldInTomorrow(alarmNowSetting)) {
        now=DateTime(now.year,now.month,now.day,alarmNowSetting.hour,alarmNowSetting.min);
        //说明此闹钟应在明天
        alarmNowSetting.meantTime=DateFormatter.format(now.add(const Duration(days:1)), DateFormatter.DATE_TIME_FORMAT);
      }else{
        now=DateTime(now.year,now.month,now.day,alarmNowSetting.hour,alarmNowSetting.min);
        alarmNowSetting.meantTime=DateFormatter.format(now, DateFormatter.DATE_TIME_FORMAT);
      }
    }
    String id=await AlarmManager.smartSetAlarm(alarmNowSetting,InvokeHandler.notifyAndSmartTurnOff);
    alarmNowSetting.id = id;
    //alarmMap[id]=alarmNowSetting;
    AlarmBox.box.put(id, alarmNowSetting);
    alarmNowSetting=Alarm.active();//重置,如果仍在原来的alarmNowSetting上修改，会影响到alarmList里的变量
    notifyListeners();
  }
  Future<void> initData() async {
    if(dataInited||isInitingData)return;
    isInitingData=true;
    await AlarmBox.openBox();
    filterActiveState();
    dataInited=true;
    isInitingData=false;
    notifyListeners();
  }
  void deleteItemById(String id) {
    //alarmMap.remove(id);
    AlarmBox.box.delete(id);
    notifyListeners();
  }
  bool turnOffAlarm(String id){
    if(!turnOffAlarmWithoutNotify(id))return false;
    notifyListeners();
    return true;
  }
  //返回是否真的取消了一个闹钟，因为有的本来状态就是关闭的
  bool turnOffAlarmWithoutNotify(String id){
    //Alarm theAlarm=alarmMap[id]!;
    Alarm theAlarm=AlarmBox.box.get(id)!;
    if(!theAlarm.isActive)return false;
    theAlarm.isActive=false;//这里也会改变alarmMap里的变量
    AlarmBox.box.put(id, theAlarm);
    List<int> ids=alarmKeyParse(id);
    for(var id in ids) {
      AlarmManager.cancelAlarm(id);
    }
    return true;
  }
  //不启用一个闹钟
  void changeAlarmActive(String id) {
    //Alarm theAlarm=alarmMap[id]!;
    Alarm theAlarm=AlarmBox.box.get(id)!;
    bool act = theAlarm.isActive;
    theAlarm.isActive=!act;
    List<int> ids=alarmKeyParse(id);
    if(act) {
      for(var id in ids) {
        AlarmManager.cancelAlarm(id);
      }
    } else {
      AlarmManager.smartSetAlarm(theAlarm, InvokeHandler.notifyAndSmartTurnOff).then(
        (value) {
          theAlarm.id=value;
          AlarmBox.box.put(id, theAlarm);
        }
      );
    }
    notifyListeners();
  }
  @override
  void dispose(){
    AlarmBox.closeBox();
    dataInited=false;
    isInitingData=false;
    super.dispose();
  }
}