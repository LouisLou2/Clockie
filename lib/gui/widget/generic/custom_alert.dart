import 'package:clockie/constant/styles/app_styles.dart';
import 'package:clockie/service/provider/penthhouse_provider.dart';
import 'package:flutter/Material.dart';

import '../../../global_context.dart';
import '../../../model/alarm_model.dart';

void showFloatingSnackBar(BuildContext context,String info) {
  final snackBar = SnackBar(
    backgroundColor: AppStyles.blueColor,
    content: const Text('This is a smooth message'),
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating, // 使用浮动行为
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0), // 设置边框圆角
    ),
    margin: const EdgeInsets.all(16.0), // 设置边距
    animation: CurvedAnimation(
      parent: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: AnimationController(
          duration: const Duration(milliseconds: 1000),
          vsync: Scaffold.of(context),
        ),
        curve: Curves.fastEaseInToSlowEaseOut,
      )),
      curve:Curves.fastEaseInToSlowEaseOut,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
void showSimpleSnackBar(BuildContext context,String info) {
  var snackBar=SnackBar(
    backgroundColor: AppStyles.blueColor,
    content:  Text(info,style: AppStyles.subTitleStyle,),
    duration: const Duration(seconds: 2)
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
void showSnackBarTooFrequently(BuildContext context){
  showSimpleSnackBar(context, "Query too frequently");
}
Widget alarmDialog(BuildContext context,String title,String desc){
  return AlertDialog(
    title: Text(title,style: AppStyles.h1Style,),
    content: Text(desc,style:AppStyles.subTitleStyle),
    actions: <Widget>[
      TextButton(
        child: const Text('Shut Down',style: AppStyles.smallButtonTxt,),
        onPressed: () {
          PenthHouseProviders.alarmProvider!.shutDownAlarm();
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: const Text('Remind Later',style: AppStyles.smallButtonTxt,),
        onPressed: () {
          PenthHouseProviders.alarmProvider!.shutDownAlarm();
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
void showAlarmRingDialog(Alarm alarm){
  showDialog<void>(
    context: GlobalContext.tabContext!,
    builder: (BuildContext context) {
      return alarmDialog(context,alarm.name!=""?alarm.name:"Untitled Alarm",alarm.desc!=""?alarm.desc:"No Description");
    },
  );
}