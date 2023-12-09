import 'package:flutter/Material.dart';

import '../../gui/page/add_alarm_page.dart';
import '../../gui/page/select_city_clock.dart';

class NavigatorManager{
  static late Map<String,WidgetBuilder> routes;
  static init(){
    routes={
      '/alarm/add': (BuildContext context)=>const AddAlarmPage(),
      '/world_clock/select':(BuildContext context)=>const SelectCityPage(),
    };
  }
}