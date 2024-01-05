import 'package:flutter/Material.dart';

import '../../../constant/styles/app_styles.dart';
import '../../../constant/widet_setting.dart';
import '../../../util/time_util.dart';

Widget cityTimeSimpleCard({required String timezone, void Function(String zone) ?ontap,required bool theme}){
  return !theme?
  Padding(
    padding: const EdgeInsets.only(right:15,left:15,bottom: 10),
    child:cityTimeSimpleBasicCard(timezone:timezone ,ontap: ontap)
  ):
  Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(right:10,left:10),
        child:cityTimeSimpleBasicCard(timezone:timezone ,ontap: ontap)
      ),
      const Divider(
        indent: 35,
        endIndent: 35,
        color: Colors.black12, // 设置横线的颜色
        height: 1, // 设置横线的高度
        thickness: 1, // 设置横线的厚度
      ),
    ],
  );
}
Widget cityTimeSimpleBasicCard({required String timezone, void Function(String zone) ?ontap}){
  return InkWell(
    borderRadius: BorderRadius.circular(WidgetSetting.cardRadius),
    onTap: (ontap!=null)?(()=>ontap(timezone)):(){},
    child: Ink(
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(WidgetSetting.cardRadius),
      ),
      padding: const EdgeInsets.all(5),
      child: ListTile(
        title: Text(TimeUtil.lastItem(timezone),style: AppStyles.h2Style),
        subtitle: Text('${TimeUtil.strExceptLastItem(timezone)} ${TimeUtil.getGMTStr(timezone)}', style: AppStyles.subTitleStyle),
      ),
    ),
  );
}