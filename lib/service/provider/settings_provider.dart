import 'package:clockie/gui/widget/generic/custom_alert.dart';
import 'package:clockie/repository/holidays_repo.dart';
import 'package:clockie/repository/setting_box.dart';
import 'package:flutter/Material.dart';

class SettingsProvider extends ChangeNotifier {
  int lastTimeStamp=0;
  int basicGap=3000;
  //设置这个showQueryTooFrequently是为了防止虽然防止用户高频点击，但是提示用户的时候也不要太频繁
  bool showQueryTooFrequently=true;
  //需要存储进数据库的设置数据
  bool skippingHolidays = false;
  late int ringtoneDuration;
  late bool vibrate;
  late bool upcomingNotification;

  void init(){
    skippingHolidays =SettingBox.getSkippingHolidays();
    ringtoneDuration=SettingBox.getRingtoneDuration()!;
    vibrate=SettingBox.getVibrate();
    upcomingNotification=SettingBox.getUpcomingNotification();
  }
  void changeSkippingHolidays(BuildContext context){
    if(!skippingHolidays){
      bool res=HolidaysRepo.ensureHolidayRepoReady();
      if(!res){
        showSimpleSnackBar(context, 'Error when getting holidays data, check your network');
        return;
      }
    }
    skippingHolidays = !skippingHolidays;
    SettingBox.setSkippingHolidays(skippingHolidays);
    notifyListeners();
  }
  void changeRingtoneDuration(int duration){
    ringtoneDuration=duration;
    SettingBox.setRingtoneDuration(duration);
    notifyListeners();
  }
  void changeVibrate(){
    vibrate=!vibrate;
    SettingBox.setVibrate(vibrate);
    notifyListeners();
  }
  void changeUpcomingNotification(){
    upcomingNotification=!upcomingNotification;
    SettingBox.setUpcomingNotification(upcomingNotification);
    notifyListeners();
  }
  void updateSkippingHolidays(BuildContext context)async{
    //获取时间戳，时间间隔过小的请求会被忽略
    int nowTimeStamp=DateTime.now().millisecondsSinceEpoch;
    if(nowTimeStamp-lastTimeStamp<basicGap){
      lastTimeStamp=nowTimeStamp;
      if(showQueryTooFrequently) showSnackBarTooFrequently(context);
      showQueryTooFrequently=false;
      return;
    }
    showQueryTooFrequently=true;
    lastTimeStamp=nowTimeStamp;
    showSimpleSnackBar(context, 'Updating holidays data...');
    bool? res=await HolidaysRepo.updateHolidays();
    switch(res){
      case null:
        showSimpleSnackBar(context, 'Updating holidays data, this may take a while');
        return;
      case false:
        showSimpleSnackBar(context, '✘ Error when getting holidays data, check your network');
        return;
      default:
        showSimpleSnackBar(context, '✔ Holidays data updated');
    }
  }
  @override
  void dispose() {
    SettingBox.closeBox();
    super.dispose();
  }
}