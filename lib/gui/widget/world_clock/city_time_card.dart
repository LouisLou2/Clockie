import 'package:clockie/constant/widet_setting.dart';
import 'package:clockie/service/provider/world_clock_provider.dart';
import 'package:clockie/service/stream/time_stream.dart';
import 'package:clockie/util/time_util.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/styles/app_styles.dart';
import '../../../util/formattor.dart';

Widget cityTimeCard(BuildContext context,String timezone) {

  WorldClockProvider provider = Provider.of<WorldClockProvider>(context,listen: false);
  return Padding(
    padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
    child: InkWell(
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
                    builder: (context, snapshot) => Text(TimeUtil.getMonthDayStr(timezone),
                        style: AppStyles.subTxtStyle),
                ),
                Text(' | ', style: AppStyles.subTxtStyle),
                Text(TimeUtil.getDiffStr(timezone),
                    style: AppStyles.subTxtStyle),
              ],
            ),
          ),
          trailing:StreamBuilder(
            stream: TimeStream.getTimeStream(1),
            initialData: Text(TimeUtil.getHourMinStr(timezone),
                style: AppStyles.timeTxtStyleB),
            builder: (context, snapshot) => Text(TimeUtil.getHourMinStr(timezone),
                style: AppStyles.timeTxtStyleB),
          ),
        ),
      ),
    ),
  );
}