import 'package:clockie/constant/styles/app_styles.dart';
import 'package:clockie/constant/widet_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
Widget button(void Function() press, Color color, String txt) {
  return InkWell(
    onTap: press,
    borderRadius: BorderRadius.circular(WidgetSetting.buttonRadius),
    child: Ink(
      height: 40.h,
      width: 140.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(WidgetSetting.buttonRadius),
      ),
      child: Center(child: Text(txt,style: AppStyles.buttonTxt)),
    ),
  );
}

Widget txtButton(Function() press,String txt,TextStyle style) => InkWell(
  onTap: press,
  borderRadius: BorderRadius.circular(25),
  child: Ink(
      height: 40,
      width: ScreenUtil().screenWidth/3,
      child: Center(child: Text(txt,style: style))
  ),
);
Widget buttonExecuteStyle({required Function() press,String? label}){
  return button(
    press,AppStyles.blueColor, label ?? "Start"
  );
}
Widget buttonMaimStyle({required Function() press,String? label}){
  return button(
    press,Colors.red,label ??'Pause'
  );
}
Widget buttonQuietStyle({required Function() press,String? label}){
  return button(
    press,Colors.grey,label??'Reset'
  );
}