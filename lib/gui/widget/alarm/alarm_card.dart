import 'package:clockie/constant/styles/style.dart';
import 'package:clockie/dict/date_dict.dart';
import 'package:clockie/service/provider/penthhouse_provider.dart';
import 'package:clockie/service/provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:clockie/constant/styles/app_styles.dart';

import '../../../service/provider/alarm_provider.dart';
Widget dayOfWeekRow(int alarmIndex){
  return SizedBox(
    height: 28,
    child: GridView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 40,
          mainAxisSpacing: 10,
          mainAxisExtent: 40
      ),
      itemCount: 7,
      itemBuilder: (context, index)=> Selector<AlarmProvider,bool>(
        selector: (context,provider) => provider.getAlarmByIndex(alarmIndex).days[index],
        builder:(context,isSelect,child)=>Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateDict.shortDays[index],
                style: isSelect?
                AppStyles.blueTxtStyle : AppStyles.subTxtStyle),
            Container(
              height: 4,
              decoration: BoxDecoration(shape: BoxShape.circle,
                  color:isSelect?
                  AppStyles.blueColor : AppStyles.softWhite),
            ),
          ],
        )
      ),
    ),
  );
}
Widget alarmBasicCard(Color backgroundColor,bool withShadow,int index){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Selector<AlarmProvider,bool>(
        selector: (context,prov)=>prov.selecting,
        builder:(context,selecting,child)=>Offstage(
          offstage: !selecting,
          child: Selector<AlarmProvider,bool>(
              selector: (context,prov)=>prov.selected[index],
              builder:(context,isSelected,child)=>Checkbox(
                visualDensity: const VisualDensity(
                  horizontal: -4, // 水平方向的密度微调
                  vertical: 0, // 垂直方向的密度微调
                ),
                value: isSelected,
                onChanged: (value){
                  PenthHouseProviders.alarmProvider!.changeItemSelected(index);
                }
              ),
          )
        ),
      ),
    Ink(
        height: 160,
        width: 360,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: !withShadow?null:[
            BoxShadow(
              color: Colors.grey.withOpacity(0.4), // 阴影颜色和透明度
              spreadRadius: 2, // 阴影扩散程度
              blurRadius: 4, // 阴影模糊程度
              offset: const Offset(0, 5), // 阴影偏移量
            ),
          ],
          color: backgroundColor,
          borderRadius: AppStyles.genericCardBorderRadius,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
                alignment: AlignmentDirectional.topStart,
                child: Selector<AlarmProvider,String>(
                    selector: (context,provider) => provider.getAlarmByIndex(index).name,
                    builder: (context,name,child) => Text(name)
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Selector<AlarmProvider,String>(
                    selector: (context,provider) => provider.getAlarmByIndex(index).timeStr,
                    builder: (context,timeStr,child) => Text(timeStr,style: AppStyles.numberStyle)
                ),
                Selector<AlarmProvider,bool>(
                  selector: (context,provider) => provider.getAlarmByIndex(index).isActive,
                  builder: (context,isActive,child) => CupertinoSwitch(
                      activeColor: AppStyles.blueColor,
                      // trackColor: AppStyles.backGroundColor,
                      value: isActive, onChanged: (value){
                    AlarmProvider prov = Provider.of<AlarmProvider>(context,listen: false);
                    prov.changeAlarmActiveByIndex(index);
                  }
                  ),
                ),
              ],
            ),
            dayOfWeekRow(index),
            Selector<AlarmProvider,int>(
                selector: (context,provider) => provider.getAlarmByIndex(index).pickNum,
                builder: (context,pickNum,child){
                  String? value;
                  switch(pickNum){
                    case 0:
                      value='Once';
                      break;
                    case 7:
                      value='Everyday';
                      break;
                    default:
                      value='$pickNum Days';
                      break;
                  }
                  return Text(value,style: AppStyles.subTxtStyle);
                }
            ),
          ],
        ),
      ),
    ],
  );
}
Widget alarmCard(int index,BuildContext context) {
  return Selector<AlarmProvider,String>(
    selector: (context,provider) => provider.ids[index],
    builder: (context,id,child) => Padding(
      padding: const EdgeInsets.only(left: 1,right: 1,bottom: 12),
      child: InkWell(
        borderRadius: AppStyles.genericCardBorderRadius,
        onTap:()=>{
          !(PenthHouseProviders.alarmProvider!.selecting)?Navigator.pushNamed(context, '/alarm/add',arguments: id):PenthHouseProviders.alarmProvider!.changeItemSelected(index),
        },
        //onLongPress: () => aprov.deleteItemByIndex(index),
        child: Selector<ThemeProvider,bool>(
          selector: (context,prov)=>prov.curTheme,
          builder:(context,isLight,child)=>isLight?
          alarmBasicCard(ThemeAffectColor.lightCardColor, true, index):
          alarmBasicCard(ThemeAffectColor.darkCardColor, false, index)
        ),
      ),
    )
  );
}