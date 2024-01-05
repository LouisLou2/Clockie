import 'package:clockie/dict/worldtime_dict.dart';
import 'package:clockie/repository/chosen_city_box.dart';
import 'package:flutter/cupertino.dart';

class WorldClockProvider extends ChangeNotifier{
  List<String> get timezonesList => ChosenCityBox.box.keys.toList().cast<String>();
  bool _dataInited=false;
  bool get isDataInited => _dataInited;
  bool get isDictInited=>WorldTimeDict.hasInited;
  int get citiesNum => ChosenCityBox.box.length;
  bool isInitingData=false;//是否正在初始化数据，引入这个变量是因为由于异步的原因，initData()可能会被多次调用，所以只调用一次
  bool resumeJustNow=false;//注意不是取决于值，而是取决于是否与之前的值不同，来代表是否是从后台切换到前台

  void changeResumeJustNow(){
    resumeJustNow=!resumeJustNow;
    notifyListeners();
  }
  Future<void>initData()async{
    if(isInitingData||_dataInited)return;
    await initWorldClockDict();
    await ChosenCityBox.openBox();
    _dataInited=true;
    isInitingData=false;
    notifyListeners();
  }
  bool selectCity(String timezone){
    if(ChosenCityBox.box.containsKey(timezone)){
      return false;
    }
    ChosenCityBox.box.put(timezone, true);
    notifyListeners();
    return true;
  }
  void removeCity(String timezone){
    ChosenCityBox.box.delete(timezone);
    notifyListeners();
  }
  Future<void> initWorldClockDict()async{
    if(WorldTimeDict.hasInited)return;
    await WorldTimeDict.init();
    notifyListeners();
  }
  @override
  void dispose(){
    ChosenCityBox.closeBox();
    _dataInited=false;
    isInitingData=false;
    super.dispose();
  }
}