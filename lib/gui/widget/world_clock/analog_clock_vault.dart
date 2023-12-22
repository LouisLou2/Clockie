import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/Material.dart';

class AnalogClockVault{
  static Widget getBlackAnalogClock()=>AnalogClock(
    decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: Colors.white70),
        color: Colors.transparent,
        shape: BoxShape.circle),
    width: 230.0,
    height:230.0,
    isLive: true,
    hourHandColor: Colors.red,
    minuteHandColor: Colors.white,
    showSecondHand: true,
    secondHandColor: Colors.white,
    numberColor: Colors.white,
    showNumbers: true,
    showAllNumbers: false,
    textScaleFactor: 1.4,
    showTicks: true,
    tickColor: Colors.white,
    showDigitalClock: true,
    datetime: DateTime.now(),
  );

}