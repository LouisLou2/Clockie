import 'package:clockie/dict/date_dict.dart';
import 'package:clockie/model/alarm_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:clockie/constant/styles/app_styles.dart';

import '../../../service/provider/alarm_provider.dart';
Widget dayOfWeekRow(String id){
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
        selector: (context,provider) => provider.getAlarm(id).days[index],
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
Widget alarmCard(String id,BuildContext context) {
  AlarmProvider prov = Provider.of<AlarmProvider>(context,listen: false);
  return Padding(
    padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
    child: InkWell(
      borderRadius: AppStyles.genericCardBorderRadius,
      onLongPress: () => prov.deleteItemById(id),
      child: Ink(
        height: 160,
        width: ScreenUtil().screenWidth/2,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppStyles.cardColor,
          borderRadius: AppStyles.genericCardBorderRadius,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Selector<AlarmProvider,String>(
                selector: (context,provider) => provider.getAlarm(id).name,
                builder: (context,name,child) => Text(name,style: AppStyles.subTxtStyle)
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Selector<AlarmProvider,String>(
                  selector: (context,provider) => provider.getAlarm(id).timeStr,
                  builder: (context,timeStr,child) => Text(timeStr,style: AppStyles.numberStyle)
                ),
                Selector<AlarmProvider,bool>(
                  selector: (context,provider) => provider.getAlarm(id).isActive,
                  builder: (context,isActive,child) => CupertinoSwitch(
                    activeColor: AppStyles.blueColor,
                    trackColor: AppStyles.backGroundColor,
                    value: isActive, onChanged: (value){
                      AlarmProvider prov = Provider.of<AlarmProvider>(context,listen: false);
                      prov.changeAlarmActive(id);
                    }
                  ),
                ),
              ],
            ),
            dayOfWeekRow(id),
            Selector<AlarmProvider,int>(
              selector: (context,provider) => provider.getAlarm(id).pickNum,
              builder: (context,pickNum,child) =>Text(pickNum==0?'Once':'$pickNum Days',style: AppStyles.subTxtStyle),
            ),
          ],
        ),
      ),
    ),
  );
}