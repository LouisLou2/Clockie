
import 'package:hive/hive.dart';

import '../util/formattor.dart';

@HiveType(typeId: 1)
class Alarm {
  static const int fieldsNum=9;
  @HiveField(0)
  late String id;//安卓闹钟id 格式是'0:1:2:3'因为一个闹钟可在一个星期中有着不规则的几天，在设置闹钟时可能需要几个真正的闹钟id，将她们几个组合起来成为这个unique id

  @HiveField(1)
  late String name;

  @HiveField(2)
  late int hour;

  @HiveField(3)
  late int min;

  @HiveField(4)
  late bool isActive;
  @HiveField(5)
  late int pickNum;
  @HiveField(6)
  late List<bool>days=[];
  @HiveField(7)
  late String desc;
  @HiveField(8)
  /*此字段仅给触发一次的对象才有意义，存储格式化字符串，不是只触发一次的这里留作空串*/
  late String meantTime;
  void defaultInit(){
    id='';
    name='';
    hour=0;
    min=0;
    isActive=false;
    pickNum=0;
    days=List<bool>.filled(7,false);
    desc='';
    meantTime='';
  }
  Alarm({required this.id,required this.name,required this.hour,required this.min,required this.isActive,required List<bool>days,required int pickNum,required this.desc,required this.meantTime}){
    pickNum=0;
    for(int i=0;i<days.length;++i){
      ++pickNum;
      this.days.add(days[i]);
    }
  }
  Alarm.empty(){
    defaultInit();
  }
  Alarm.notDecideDays({required this.id,required this.name,required this.hour,required this.min,required this.isActive,required this.pickNum,required this.desc,required this.meantTime}){
    days=List<bool>.filled(7,false);
  }
  Alarm.active(){
    defaultInit();
    isActive=true;
  }
  void changeDay(int index){
    if(days[index]) {
      --pickNum;
    } else {
      ++pickNum;
    }
    days[index]=!days[index];
  }
  void setDays(int index,bool newDays){
    if(days[index]==newDays)return;
    if(newDays) {
      ++pickNum;
    } else {
      --pickNum;
    }
    days[index]=newDays;
  }
  String get timeStr {
    return '${hour >= 10 ? '$hour' : '0$hour'}:${min >= 10 ? '$min' : '0$min'}';
  }
  void setMeanTime(DateTime time){
    meantTime=DateFormatter.format(time, DateFormatter.DATE_TIME_FORMAT);
  }
  static copyWith(Alarm alarm){
    return Alarm(
      id: alarm.id,
      name: alarm.name,
      hour: alarm.hour,
      min: alarm.min,
      isActive: alarm.isActive,
      pickNum: alarm.pickNum,
      days: List.from(alarm.days),
      desc: alarm.desc,
      meantTime: alarm.meantTime,
    );
  }
}