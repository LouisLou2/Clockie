import 'package:clockie/gui/widget/generic/custom_alert.dart';
import 'package:clockie/repository/holidays_repo.dart';
import 'package:clockie/repository/setting_box.dart';
import 'package:flutter/Material.dart';

class SettingsProvider extends ChangeNotifier {
  bool skippingHolidays = false;
  void init(){
    skippingHolidays =SettingBox.getSkippingHolidays();
  }
  void changeSkippingHolidays(BuildContext context){
    if(!skippingHolidays){
      bool res=HolidaysRepo.ensureHolidayRepoReady();
      if(!res){
        showSimpleSnackBar(context, 'Error when getting holidays data, try again later');
        return;
      }
    }
    skippingHolidays = !skippingHolidays;
    SettingBox.setSkippingHolidays(skippingHolidays);
    notifyListeners();
  }
}