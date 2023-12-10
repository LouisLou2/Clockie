import 'package:flutter/Material.dart';

import '../../../constant/styles/app_styles.dart';
import '../../../constant/widet_setting.dart';
import '../../../util/time_util.dart';

Widget cityTimeSimpleCard({required String timezone, void Function(String zone) ?ontap}){
  return Padding(
    padding: const EdgeInsets.only(left:10, right: 10,bottom: 10),
    child: InkWell(
      borderRadius: BorderRadius.circular(WidgetSetting.cardRadius),
      onTap: (ontap!=null)?(()=>ontap(timezone)):(){},
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(WidgetSetting.cardRadius),
        ),
        padding: const EdgeInsets.all(5),
        child: ListTile(
          title: Text(TimeUtil.lastItem(timezone),style: AppStyles.titleStyle),
          subtitle: Text('${TimeUtil.strExceptLastItem(timezone)} ${TimeUtil.getGMTStr(timezone)}', style: AppStyles.subTitleStyle),
        ),
      ),
    ),
  );
}