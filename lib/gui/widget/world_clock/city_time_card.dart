import 'package:clockie/constant/widet_setting.dart';
import 'package:clockie/service/provider/world_clock_provider.dart';
import 'package:clockie/service/stream/time_stream.dart';
import 'package:clockie/util/time_util.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../constant/styles/app_styles.dart';
import '../../../util/formattor.dart';
Widget getCityTimeCard(BuildContext context,String timezone,bool theme) {
  return theme?Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(right:10,left:10),
        child:cityTimeCard(context,timezone),
      ),
      const Divider(
        indent: 35,
        endIndent: 35,
        color: Colors.black12, // 设置横线的颜色
        height: 1, // 设置横线的高度
        thickness: 1, // 设置横线的厚度
      ),
    ],
  ):Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(right:15,left:15,bottom: 10),
        child:cityTimeCard(context,timezone),
      ),
    ],
  );
}
Widget cityTimeCard(BuildContext context,String timezone) {
  WorldClockProvider provider = Provider.of<WorldClockProvider>(context,listen: false);
  return InkWell(
    borderRadius: BorderRadius.circular(WidgetSetting.cardRadius),
    onLongPress: () => provider.removeCity(timezone),
    child: Ink(
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(WidgetSetting.cardRadius),
      ),
      padding: EdgeInsets.only(left: 10,right: 10,top: 10.h,bottom: 10.h),
      child: ListTile(
        title: Text(DateFormatter.timezoneStrToLocationStr(timezone),
            style: AppStyles.timeTxtStyleB),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10),
          child:Row(
            children: [
              StreamBuilder(
                  stream: TimeStream.getTimeStream(3),
                  initialData: Text(TimeUtil.getMonthDayStr(timezone),
                      style: AppStyles.subTxtStyle),
                  builder: (context, snapshot) => Selector<WorldClockProvider,bool>(
                    selector: (context,provider)=>provider.resumeJustNow,
                    builder: (context,resumeJustNow,child)=>Text(TimeUtil.getMonthDayStr(timezone),
                        style: AppStyles.subTxtStyle),
                  )
              ),
              const Text(' | ', style: AppStyles.subTxtStyle),
              Text(TimeUtil.getDiffStr(timezone),
                  style: AppStyles.subTxtStyle),
            ],
          ),
        ),
        trailing:StreamBuilder(
          stream: TimeStream.getTimeStream(1),
          initialData: Text(TimeUtil.getHourMinStr(timezone),
              style: AppStyles.timeTxtStyleB),
          builder: (context, snapshot) => Selector<WorldClockProvider,bool>(
            selector: (context,provider)=>provider.resumeJustNow,
            builder: (context,resumeJustNow,child)=>Text(TimeUtil.getHourMinStr(timezone),
                style: AppStyles.timeTxtStyleB),
          ),
        ),
      ),
    ),
  );
}