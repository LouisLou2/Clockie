import 'package:clockie/gui/widget/generic/time_picker.dart';
import 'package:clockie/service/provider/penthhouse_provider.dart';
import 'package:flutter/Material.dart';

class TimerTimePicker extends StatefulWidget{
  const TimerTimePicker({Key? key}) : super(key: key);

  @override
  State<TimerTimePicker> createState() => _TimerTimePickerState();
}

class _TimerTimePickerState extends State<TimerTimePicker> {
  final FixedExtentScrollController _hourController = FixedExtentScrollController();
  final FixedExtentScrollController _minuteController = FixedExtentScrollController();
  final FixedExtentScrollController _secondController = FixedExtentScrollController();

  // void updateChange(int ele){
  //   final prov = Provider.of<TimerProvider>(context,listen: false);
  //   switch(ele){
  //     case 0:
  //       prov.hour = _hourController.selectedItem;
  //       break;
  //     case 1:
  //       prov.min = _minuteController.selectedItem;
  //       break;
  //     case 2:
  //       prov.sec = _secondController.selectedItem;
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return FullTimePicker(
      withTitle: true,
      hourController: _hourController,
      minuteController: _minuteController,
      secondController: _secondController,
      onHourChanged: (value) => PenthHouseProviders.timerProvider!.hour=value!,
      onMinuteChanged: (value) => PenthHouseProviders.timerProvider!.min=value!,
      onSecondChanged: (value) => PenthHouseProviders.timerProvider!.sec=value!,
    );
  }
}