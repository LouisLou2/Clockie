import 'package:clockie/global_context.dart';
import 'package:clockie/repository/setting_box.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';
import 'package:tuple/tuple.dart';

import '../../dict/theme_enum.dart';

class ThemeProvider with ChangeNotifier {
  bool curTheme=false;//true表示为亮色
  bool withSys=false;//是否跟随系统颜色
  get themeSetting=>Tuple2<bool,bool>(curTheme, withSys);

  void init(){
    int code=SettingBox.getThemeCode();
    withSys=code==ThemeEnum.followSystem.index;
    //这是还不能设置curTheme,因为执行到这里的时候还没有context
    if(withSys)return;
    curTheme=code==ThemeEnum.light.index;
  }
  void changeTheme(int code, BuildContext context) {
    if (code == ThemeEnum.followSystem.index) {
      if(withSys)return;
      beginWithSys(context);
      notifyListeners();
      return;
    }
    if (withSys) {
      noMoreWithSys();
    }
    bool targetTheme = (code == ThemeEnum.light.index);
    if (targetTheme != curTheme) {
      changeLightDark();
    }
    notifyListeners();
  }
  void onPlatFormBrightnessChange(){
    if(!withSys)return;
    bool nowSysTheme=MediaQuery.platformBrightnessOf(GlobalContext.tabContext!)==Brightness.light;
    if(curTheme==nowSysTheme)return;
    curTheme=nowSysTheme;
    changeNavbar();
    notifyListeners();
  }
  //此函数不会notifyListeners
  void changeNavbar(){
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: curTheme?Colors.white:Colors.black,
        )
    );
  }
  //此函数不会notifyListeners
  void changeLightDark(){
    curTheme=!curTheme;
    SettingBox.setThemeCode(curTheme?ThemeEnum.light.index:ThemeEnum.dark.index);
    changeNavbar();
  }
  //此函数不会notifyListeners
  void beginWithSys(BuildContext context){
    withSys=true;
    bool nowSysTheme=MediaQuery.platformBrightnessOf(context)==Brightness.light;
    if(curTheme==nowSysTheme)return;
    curTheme=nowSysTheme;
    SettingBox.setThemeCode(nowSysTheme?ThemeEnum.light.index:ThemeEnum.dark.index);
    changeNavbar();
  }
  //此函数不会notifyListeners
  void noMoreWithSys(){
    withSys=false;
  }
}