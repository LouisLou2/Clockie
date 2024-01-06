import 'package:clockie/constant/styles/app_styles.dart';
import 'package:flutter/Material.dart';

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
Widget alarmDialog(BuildContext context,String title,String desc){
  return AlertDialog(
    title: Text(title),
    content: Text(desc),
    actions: <Widget>[
      TextButton(
        style: TextButton.styleFrom(
          textStyle: Theme.of(context).textTheme.labelLarge,
        ),
        child: const Text('Shut Down'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          textStyle: Theme.of(context).textTheme.labelLarge,
        ),
        child: const Text('Remind Later'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}