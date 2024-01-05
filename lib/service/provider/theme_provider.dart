import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';
import 'package:tuple/tuple.dart';

class ThemeProvider with ChangeNotifier {
  bool curTheme=false;//true表示为亮色
  bool withSys=false;//是否跟随系统颜色
  get themeSetting=>Tuple2<bool,bool>(curTheme, withSys);
  void changeTheme(int code,BuildContext context){
    if(code==2&&!withSys){
      beginWithSys(context);
      notifyListeners();
      return;
    }
    if(code==2)return;
    if(code!=2&&withSys){
      noMoreWithSys();
    }
    bool targetTheme=code==0;
    if(targetTheme!=curTheme){
      changeThemeSelection();
    }
    notifyListeners();
  }
  void init(){}
  void changeNavbar(){
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: curTheme?Colors.white:Colors.black,
        )
    );
  }
  void changeThemeSelection(){
    curTheme=!curTheme;
    changeNavbar();
  }
  void beginWithSys(BuildContext context){
    withSys=true;
    bool nowSysTheme=MediaQuery.platformBrightnessOf(context)==Brightness.light;
    if(curTheme==nowSysTheme)return;
    curTheme=nowSysTheme;
    changeNavbar();
  }
  void noMoreWithSys(){
    withSys=false;
  }
}