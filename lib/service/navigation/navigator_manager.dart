import 'package:clockie/gui/page/more_setting.dart';
import 'package:flutter/Material.dart';

import '../../gui/page/add_alarm_page.dart';
import '../../gui/page/chose_ringtone.dart';
import '../../gui/page/select_city_clock.dart';

class NavigatorManager{
  static late Map<String,WidgetBuilder> routes;
  static init(){
    routes={
      '/alarm/add': (BuildContext context)=>const AddAlarmPage(),
      '/alarm/more':(BuildContext context)=>const MoreSettingPage(),
      '/world_clock/select':(BuildContext context)=>const SelectCityPage(),
      '/alarm/more/ringtone':(BuildContext context)=>const GridViewExampleApp(),
    };
  }
}