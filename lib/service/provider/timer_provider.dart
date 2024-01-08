import 'dart:async';

import 'package:clockie/constant/widet_setting.dart';
import 'package:clockie/gui/widget/generic/custom_alert.dart';
import 'package:clockie/service/notification/notification_vault.dart';
import 'package:flutter/Material.dart';

class TimerProvider extends ChangeNotifier{
  static const mostHour=24;
  BuildContext? timerPageContext;
  int _hour=0;
  int _min=0;
  int _sec=0;
  int _milliSum=0;
  int _milliLeft=0;
  bool _isRunning=false;
  Timer? _timer;
  //getters
  double get percent=>_milliLeft/_milliSum;
  get milliLeft=>_milliLeft;
  get secLeft=>_milliLeft~/1000;
  get isRunning=>_isRunning;
  get timerActive=>_timer?.isActive;
  //setters
  set hour(int hour)=>_hour=hour%mostHour;
  set min(int minute)=>_min=minute%60;
  set sec(int second)=>_sec=second%60;
  set secSum(int milliSum)=>_milliSum=milliSum;

  void _timerChangeCallback(Timer timer)async{
    if(_milliLeft>0) {
      _milliLeft-=WidgetSetting.updateInterval;
      notifyListeners();
      return;
    }
    if(timerPageContext!=null) {
      NotificationVault.showTimeExpiryNotification(timerPageContext!);
    }
    reset();
  }
  void start(BuildContext context){
    timerPageContext=context;
    if(_hour==0&&_min==0&&_sec==0){
      showSimpleSnackBar(context,'Please select time');
      return;
    }
    _isRunning=true;
    _milliSum=_hour*3600+_min*60+_sec;
    _milliSum*=1000;
    _milliLeft=_milliSum;
    _timer=Timer.periodic(const Duration(milliseconds: WidgetSetting.updateInterval), _timerChangeCallback);
    notifyListeners();
  }
  void countingStateChange(){
    if(timerActive) {
      _timer?.cancel();
    } else {
      _timer=Timer.periodic(const Duration(milliseconds: WidgetSetting.updateInterval), _timerChangeCallback);
    }
    notifyListeners();
  }
  void reset(){
    _timer?.cancel();
    _isRunning=false;
    _hour=0;
    _min=0;
    _sec=0;
    notifyListeners();
  }
}