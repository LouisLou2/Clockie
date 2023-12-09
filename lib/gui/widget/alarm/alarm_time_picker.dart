import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../service/provider/alarm_provider.dart';
import '../generic/time_picker.dart';

class AlarmTimePicker extends StatefulWidget {
  const AlarmTimePicker({super.key});

  @override
  State<AlarmTimePicker> createState() => _AlarmTimePickerState();
}

class _AlarmTimePickerState extends State<AlarmTimePicker> {

  final FixedExtentScrollController _hourController = FixedExtentScrollController(initialItem: DateTime.now().hour);
  final FixedExtentScrollController _minuteController = FixedExtentScrollController(initialItem: DateTime.now().minute);
  double itemExtent = 80;

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
  //生命周期方法
  @override
  void initState() {
    super.initState();
    _initAlarm();
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