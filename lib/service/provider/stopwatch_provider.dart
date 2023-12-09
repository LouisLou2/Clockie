import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:clockie/model/base_time.dart';
import 'package:clockie/model/lap.dart';
class StopWatchProvider extends ChangeNotifier{
  int min=0;
  int sec=0;
  int mili=0;
  bool isRunning=false;
  Timer? timer;
  List<Lap> lapList=[];
  get timerActive=>timer?.isActive;
  void start(){
    isRunning=true;
    timer=Timer.periodic(const Duration(milliseconds: 10), (timer) {
      ++mili;
      if(mili>99){
        ++sec;
        mili=0;
      }
      if(sec>59){
        ++min;
        sec=0;
      }
      notifyListeners();
    });
  }

  void pause(){
    timer!.cancel();
    notifyListeners();
  }

  void reset(){
    isRunning=false;
    timer!.cancel();
    min=0;
    sec=0;
    mili=0;
    lapList.clear();
    notifyListeners();
  }

  void addLap(){
    lapList.add(Lap(lapList.length+1,BaseTime.toTimeStr(min, sec, mili)));
    notifyListeners();
  }
}