import 'dart:async';

import 'package:clockie/repository/alarm_box.dart';
import 'package:clockie/service/invoke_handler.dart';
import 'package:clockie/util/formattor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/alarm_model.dart';
import '../../util/time_util.dart';
import '../alarm_manager.dart';

class AlarmProvider extends ChangeNotifier {
  bool shouldRing=false;
  String alarmNowRinging="";
  Alarm alarmNowSetting = Alarm.active();
  Alarm? backupAlarmNow;
  bool editingAlarm = false;//这里说明正在设置一个先前已经存在的闹钟，设置这个标着的目的就是，先前已经存在的闹钟，先要先把原来的取消掉
  List<String>ids=[];//单独设置这个，为了防止修改闹钟导致全列表刷新
  get alarmList=>AlarmBox.box.values.toList(growable: false);
  bool dataInited=false;
  bool get isDataInited => dataInited;
  int get alarmNum => ids.length;
  bool isInitingData=false;//是否正在初始化数据，引入这个变量是因为由于异步的原因，initData()可能会被多次调用，所以只调用一次

  void giveupEditing(){
    editingAlarm=false;
  }
  //以下是关于gui中多选delete的
  late List<bool>selected;
  bool selecting=false;
  bool selectAllCheck=false;
  void changeSelecting(){
    selecting=!selecting;
    //只在选完的时候将那些状态置为false
    if(!selecting){
      selectAllCheck=false;
      for(int i=0;i<selected.length;++i){
        if(selected[i])selected[i]=false;
      }
    }
    notifyListeners();
  }
  void changeItemSelected(int index){
    selected[index]=!selected[index];
    notifyListeners();
  }
  void selectAllOrNot(bool select){
    if(select){
      selectAllCheck=true;
      for(int i=0;i<selected.length;++i){
        selected[i]=true;
      }
    }else{
      selectAllCheck=false;
      for(int i=0;i<selected.length;++i){
        if(selected[i])selected[i]=false;
      }
    }
    notifyListeners();
  }
  void deletedSelected(){
    int len=selected.length;
    for(int i=len-1;i>=0;--i){
      if(selected[i]){
        _deleteAlarmWithouNotify(i);
      }
    }
    changeSelecting();
    notifyListeners();
  }
  String getIdByIndex(int index){
    return ids[index];
  }
  Alarm getAlarm(String id) {
    return AlarmBox.box.get(id)!;
  }
  Alarm getAlarmByIndex(int index){
    return getAlarm(ids[index]);
  }
  void pickDay(int index) {
    alarmNowSetting.changeDay(index);
    notifyListeners();
  }
  void alarmNowSettingWithExisting(String id) {
    alarmNowSetting = AlarmBox.box.get(id)!;
    //backupAlarmNow = Alarm.copyWith(alarmNowSetting);
    editingAlarm = true;
  }
  ///这个不仅是将过期闹钟的状态改为false，还会将把应该Active的闹钟再次重新设置一遍，
  ///因为我发现我只要一离开应用（Swiped）,再次进入，即使闹钟应该是Active的，也不会触发，所以再次设置一遍
  ///如果这个问题解决了，那么这个方法就不必那么麻烦了
  void filterActiveState(){
    DateTime now=DateTime.now();
    DateFormat formatter=DateFormat(DateFormatter.DATE_TIME_FORMAT);
    DateTime? that;
    for(var entry in AlarmBox.box.toMap().entries) {
      ids.add(entry.key);
      if(entry.value.pickNum!=0){
        AlarmManager.smartSetAlarmWithExistingId(entry.value, InvokeHandler.notifyAndSmartTurnOff);
        continue;
      }
      that=formatter.parse(entry.value.meantTime);
      if(that.isAfter(now)){
        AlarmManager.smartSetAlarmWithExistingId(entry.value, InvokeHandler.notifyAndSmartTurnOff);
        continue;
      }
      entry.value.isActive=false;
      AlarmBox.box.put(entry.key, entry.value);
    }
    selected=List.generate(ids.length, (index) => false);
  }
  void setNowAlarmNameAndDesc(String alarmName,String desc) {
    alarmNowSetting.name = alarmName;
    alarmNowSetting.desc = desc;
  }
  void submitAlarm() async {
    int? index;
    if(editingAlarm) {
      index=ids.indexOf(alarmNowSetting.id);
      removeAlarmFromBoxAndDisregister(index);
    }
    bool isOnce=alarmNowSetting.pickNum==0;
    if(isOnce) {
      TimeUtil.equipMeanTime(alarmNowSetting);
    }
    String id=await AlarmManager.smartSetAlarm(alarmNowSetting,InvokeHandler.notifyAndSmartTurnOff);
    alarmNowSetting.id = id;
    if(editingAlarm) {
      ids[index!]=id;
    } else {
      ids.add(id);
      selected.add(false);
    }
    AlarmBox.box.put(id, alarmNowSetting);
    alarmNowSetting=Alarm.active();//重置,如果仍在原来的alarmNowSetting上修改，会影响到alarmList里的变量
    if(editingAlarm)editingAlarm=false;//不要忘了把这个标志位重置
    notifyListeners();
  }
  Future<void> initData() async {
    if(dataInited||isInitingData)return;
    isInitingData=true;
    await AlarmBox.openBox();
    filterActiveState();
    dataInited=true;
    isInitingData=false;
    editingAlarm=false;
    notifyListeners();
  }
  //暂时废弃
  void ___deleteItemByIndex(int ind){
    _deleteAlarmWithouNotify(ind);
    notifyListeners();
  }
  void removeAlarmFromBoxAndDisregister(int index){
    String id=ids[index];
    if(AlarmBox.box.get(id)!.isActive){
      List<int> ids=alarmKeyParse(id);
      for(var id in ids) {
        AlarmManager.cancelAlarm(id);
      }
    }
    AlarmBox.box.delete(id);
  }
  //此方法是删除脑中的单元方法，不可以用id,只能用index
  void _deleteAlarmWithouNotify(int index) {
    removeAlarmFromBoxAndDisregister(index);
    ids.removeAt(index);
    selected.removeAt(index);
  }
  bool turnOffAlarm(String id){
    if(!turnOffAlarmWithoutNotify(id))return false;
    notifyListeners();
    return true;
  }
  //返回是否真的取消了一个闹钟，因为有的本来状态就是关闭的
  bool turnOffAlarmWithoutNotify(String id){
    Alarm theAlarm=AlarmBox.box.get(id)!;
    if(!theAlarm.isActive)return false;
    theAlarm.isActive=false;
    AlarmBox.box.put(id, theAlarm);
    List<int> ids=alarmKeyParse(id);
    for(var id in ids) {
      AlarmManager.cancelAlarm(id);
    }
    return true;
  }
  void changeAlarmActiveByIndex(int index){
    changeAlarmActive(ids[index]);
  }
  //不启用一个闹钟
  void changeAlarmActive(String id) {
    Alarm theAlarm=AlarmBox.box.get(id)!;
    bool act = theAlarm.isActive;
    theAlarm.isActive=!act;
    AlarmBox.box.put(id, theAlarm);
    List<int> ids=alarmKeyParse(id);
    if(act) {
      for(var aid in ids) {
        AlarmManager.cancelAlarm(aid);
      }
    } else {
      AlarmManager.smartSetAlarmWithExistingId(theAlarm, InvokeHandler.notifyAndSmartTurnOff);
    }
    notifyListeners();
  }
  void ringAlarm(String id){
    alarmNowRinging=id;
    shouldRing=true;
    notifyListeners();
  }
  void shutDownAlarm(){
    shouldRing=false;
  }
  @override
  void dispose(){
    AlarmBox.closeBox();
    dataInited=false;
    isInitingData=false;
    super.dispose();
  }
}