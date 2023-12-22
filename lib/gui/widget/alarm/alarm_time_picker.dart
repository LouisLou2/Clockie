import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../service/provider/alarm_provider.dart';
import '../generic/time_picker.dart';

class AlarmTimePicker extends StatefulWidget {

  const AlarmTimePicker({super.key,this.initialHour,this.initialMinute});
  final int? initialHour;
  final int? initialMinute;
  @override
  State<AlarmTimePicker> createState() => _AlarmTimePickerState();
}

class _AlarmTimePickerState extends State<AlarmTimePicker> {

  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  double itemExtent = 80;
  @override
  initState() {
    super.initState();
    _hourController = FixedExtentScrollController(initialItem: widget.initialHour??DateTime.now().hour);
    _minuteController = FixedExtentScrollController(initialItem: widget.initialMinute??DateTime.now().minute);
    _initAlarm();
  }
  //逻辑方法

  _pickTime(int? hourValue, int? minuteValue) {
    final provider = Provider.of<AlarmProvider>(context,listen: false);
    if(hourValue!=null) provider.alarmNowSetting.hour = hourValue;
    if(minuteValue!=null) provider.alarmNowSetting.min = minuteValue;
  }

  _initAlarm() {
    final provider = Provider.of<AlarmProvider>(context,listen: false);
    provider.alarmNowSetting.hour = _hourController.initialItem;
    provider.alarmNowSetting.min = _minuteController.initialItem;
  }
  @override
  Widget build(BuildContext context)  =>
      hourMinPicker(
          hourController: _hourController,
          minuteController: _minuteController,
          onHourChanged: (value) => _pickTime(value, null),
          onMinuteChanged: (value) => _pickTime(null, value),
      );
}