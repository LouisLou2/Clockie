import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/Material.dart';

class AnalogClockVault{
  static Widget getBlackAnalogClock(
  Color hourHandColor,
  Color minSecHandColor,
  Color borderColor,
  Color tickColor,
  Color numColor)=>AnalogClock(
    decoration: BoxDecoration(
        border: Border.all(width: 2.0,color: borderColor),
        color: Colors.transparent,
        shape: BoxShape.circle),
    width: 230.0,
    height:230.0,
    isLive: true,
    hourHandColor: hourHandColor,
    minuteHandColor: minSecHandColor,
    showSecondHand: true,
    secondHandColor: minSecHandColor,
    numberColor: numColor,
    showNumbers: true,
    showAllNumbers: false,
    showDigitalClock: false,
    textScaleFactor: 1.4,
    showTicks: true,
    tickColor: tickColor,
    datetime: DateTime.now(),
  );
}