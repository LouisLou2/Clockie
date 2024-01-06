import 'package:clockie/constant/widet_setting.dart';
import 'package:flutter/Material.dart';

import '../../../constant/styles/app_styles.dart';
import '../../../constant/symbol.dart';

Widget timeEleTxt(int t) {
  return Center(
    child: Text(t<10 ? '0$t' : "$t",
        style: AppStyles.numberStyle),
  );
}
Widget timeSeperator() => const Text(
    SymbolConstant.timeSeparator, textAlign: TextAlign.center,
    style: AppStyles.numberStyle
);
Widget oneTimePicker({
  required FixedExtentScrollController controller,
  required int itemCount,
  required Function(int?) onSelectedItemChanged,
  String? txt,
  double singlePickerHeight = WidgetSetting.singlePickerHeight,
  double singlePickerWidth = WidgetSetting.singlePickerWidth,
}){
  List<Widget> widlist=[];
  if(txt!=null) {
    widlist.add(Text(txt,style: AppStyles.timeTxtStyleB));
    widlist.add(const SizedBox(height: WidgetSetting.timePickerTitleDistance));
  }
  widlist.add(SizedBox(
    width: singlePickerWidth,
    height: singlePickerHeight,
    child:ListWheelScrollView.useDelegate(
        controller: controller,
        useMagnifier: true,
        magnification: 1.2,
        itemExtent: WidgetSetting.listWheelItemExtent,
        diameterRatio: WidgetSetting.listWheelDiameterRatio,//滚轮的直径与视口直径的比率
        onSelectedItemChanged: onSelectedItemChanged,
        physics: const RangeMaintainingScrollPhysics(),//滚轮的物理特性: FixedExtentScrollPhysics()固定大小的滚轮
        childDelegate: ListWheelChildLoopingListDelegate(
          children: List<Widget>.generate(itemCount, (index) {
            return timeEleTxt(index);
          })
        ),
      ),
    ),
  );
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: widlist,
  );
}
Widget FullTimePicker({
  bool withTitle = false,
  required FixedExtentScrollController hourController,
  required FixedExtentScrollController minuteController,
  FixedExtentScrollController? secondController,
  required Function(int?) onHourChanged,
  required Function(int?) onMinuteChanged,
  Function(int?)? onSecondChanged,
  double singlePickerHeight = WidgetSetting.singlePickerHeight,
  double singlePickerWidth = WidgetSetting.singlePickerWidth,
}) {
  double yoffset = 0;
  if(secondController!=null) yoffset = WidgetSetting.timePickerTitleDistance;

  assert((secondController==null)==(onSecondChanged==null));
  List<Widget>widgetList = [
    oneTimePicker(
        controller: hourController,
        itemCount: 24,
        onSelectedItemChanged: onHourChanged,
        txt: (withTitle? "Hour" : null),
        singlePickerHeight: singlePickerHeight,
        singlePickerWidth: singlePickerWidth
    ),
    Center(
      child: Transform.translate(
        offset: Offset(0, yoffset),
        child: timeSeperator()
      ), // 这里放置你的组件
    ),
    oneTimePicker(
        controller: minuteController,
        itemCount: 60,
        onSelectedItemChanged: onMinuteChanged,
        txt: (withTitle? "Minute" : null),
        singlePickerHeight: singlePickerHeight,
        singlePickerWidth: singlePickerWidth
      ),
    ];
  if(secondController!=null) {
    widgetList.add(
        Center(
          child: Transform.translate(
              offset: Offset(0, yoffset),
              child: timeSeperator()
        ), // 这里放置你的组件
      ),
    );
    widgetList.add(
      oneTimePicker(
        controller: secondController,
        itemCount: 60,
        onSelectedItemChanged: onSecondChanged!,
        txt: (withTitle? "Second" : null),
        singlePickerHeight: singlePickerHeight,
        singlePickerWidth: singlePickerWidth
      ),
    );
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: widgetList,
  );
}
Widget hourMinPicker({
  bool withTitle = false,
  required FixedExtentScrollController hourController,
  required FixedExtentScrollController minuteController,
  required Function(int?) onHourChanged,
  required Function(int?) onMinuteChanged,
  double singlePickerHeight = WidgetSetting.singlePickerHeight,
  double singlePickerWidth = WidgetSetting.singlePickerWidth,
}) => FullTimePicker(
  withTitle: withTitle,
  hourController: hourController,
  minuteController: minuteController,
  onHourChanged: onHourChanged,
  onMinuteChanged: onMinuteChanged,
  singlePickerHeight: singlePickerHeight,
  singlePickerWidth: singlePickerWidth,
);