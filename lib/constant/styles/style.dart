import 'package:clockie/constant/styles/app_styles.dart';
import 'package:flutter/Material.dart';

class ThemeVault {
  static final ThemeData lightTheme = ThemeData.light();
  static final ThemeData darkTheme = ThemeData.dark();
  static ThemeData getThemeByBrightness(bool theme){
    return theme?lightTheme:darkTheme;
  }
}
class ThemeAffectColor{
  static const lightCardColor=AppStyles.softAzure;
  static const darkCardColor=Colors.white12;
}
class PrettifyScheme{
  static final defaultBoxShadow=BoxShadow(
    color: Colors.grey.withOpacity(0.4), // 阴影颜色和透明度
    spreadRadius: 2, // 阴影扩散程度
    blurRadius: 4, // 阴影模糊程度
    offset: const Offset(0, 5), // 阴影偏移量
  );
}
class AnalogClockColorScheme{
  static Color lightHourHand=Colors.red;
  static Color lightMinSecHand=Colors.black;
  static Color lightBorder=Colors.black;
  static Color lightTick=Colors.black;
  static Color lightNumber=Colors.black;
  static Color darkHourHand=Colors.deepOrange;
  static Color darkMinSecHand=Colors.white;
  static Color darkBorder=Colors.white;
  static Color darkTick=Colors.white;
  static Color darkNumber=Colors.white;
  static Color getHourHand(bool theme){
    return theme?lightHourHand:darkHourHand;
  }
  static Color getMinSecHand(bool theme){
    return theme?lightMinSecHand:darkMinSecHand;
  }
  static Color getBorder(bool theme){
    return theme?lightBorder:darkBorder;
  }
  static Color getTick(bool theme){
    return theme?lightTick:darkTick;
  }
  static Color getNumber(bool theme){
    return theme?lightNumber:darkNumber;
  }
}
class BorderEnum{
  static const ShapeBorder circleLike=CircleBorder();
  static final ShapeBorder roundedRect=RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0), // 指定圆角大小
  );
}