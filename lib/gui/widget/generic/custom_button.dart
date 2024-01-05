import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import '../../../constant/styles/style.dart';

Widget getFloatingButton({required bool theme,required void Function() onPressd,required Icon icon,String?toolTip,required bool circle}){
  return FloatingActionButton(
      highlightElevation: 5,
      onPressed: onPressd,
      shape:circle?BorderEnum.circleLike:BorderEnum.roundedRect,
      foregroundColor: Colors.black,
      backgroundColor: Colors.white70,
      tooltip: toolTip,
      child: icon,
  );
}
Widget getRoundedButton({required bool theme,required void Function() onPressd,required Icon icon,required Color iconColor,double? iconSize}){
  return ElevatedButton(
    onPressed: onPressd,
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            Colors.white
        ),
        elevation: MaterialStateProperty.all<double>(
            5
        ),
        surfaceTintColor: MaterialStateProperty.all<Color>(
            iconColor!=Colors.black?iconColor:Colors.white
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(70,70),
        ),
        iconSize: MaterialStateProperty.all<double>(
            iconSize??45
        ),
        iconColor: MaterialStateProperty.all<Color>(
            iconColor
        ),
        shape: MaterialStateProperty.all<CircleBorder>(
          const CircleBorder(),
        )
    ),
    child: icon,
  );
}
Widget playIconButton({required bool theme,required void Function() onPressd}){
  return getRoundedButton(
      onPressd: onPressd,
      theme:theme,
      icon:const Icon(Icons.play_arrow_rounded),
      iconColor: theme?Colors.blue:Colors.cyan
  );
}
Widget pauseIconButton({required bool theme,required void Function() onPressd}){
  return getRoundedButton(
    onPressd: onPressd,
    theme:theme,
    icon:const Icon(Icons.pause),
    iconColor: Colors.red
  );
}
Widget resetIconButton({required bool theme,required void Function() onPressd}){
  return getRoundedButton(
    onPressd: onPressd,
    theme:theme,
    icon:const Icon(Icons.square_rounded,size: 36,),
    iconColor: Colors.grey,
  );
}
Widget lapIconButton({required bool theme,required void Function() onPressd}){
  return getRoundedButton(
      onPressd: onPressd,
      theme:theme,
      icon:const Icon(CupertinoIcons.pen),
      iconColor: Colors.blue
  );
}
