import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:clockie/constant/command_code.dart';
import 'package:clockie/model/command_message.dart';
import 'package:clockie/service/alarm_manager.dart';
import 'package:clockie/service/invoke_handler.dart';
import 'package:clockie/service/provider/penthhouse_provider.dart';

import '../repository/alarm_box.dart';

class AlarmIsolateHandler{
  static const String portName="alarm_port";
  //必须在alarmProvider被放进结构树之后调用
  static void init(){
    // 将ReceivePort对象注册到IsolateNameServer中，并用特定名称关联它
    ReceivePort receivePort = ReceivePort();
    IsolateNameServer.registerPortWithName(receivePort.sendPort, portName);
    // 监听来自其他isolate的消息
    receivePort.listen(onData);
  }
  static void onData(dynamic message){
    Map<String, dynamic> params = jsonDecode(message) as Map<String, dynamic>;
    final cmd=CommandMessage.fromJson(params);//item1是命令，item2是参数（闹钟id）
    PenthHouseProviders.alarmProvider!.ringAlarm(cmd.id);
    if(cmd.cmdCode==CommandCode.TurnOffAlarm) {
      if(PenthHouseProviders.alarmProvider==null)throw Exception('AlarmIsolateHandler: alarmProvider is not initialized');
      PenthHouseProviders.alarmProvider!.turnOffAlarm(cmd.id);
    }else if(cmd.cmdCode==CommandCode.restartAlarmNextWeek){
      if(PenthHouseProviders.alarmProvider==null)throw Exception('AlarmIsolateHandler: alarmProvider is not initialized');
      //下面这个时间不能用DateTime.now().add(Duration(days:7));因为我怕万一有延迟，这延迟会积累越来越大,但是我烦了，就这样吧
      AlarmManager.setAlarmForLoop(id: cmd.uniqueId, unitId: cmd.id, alarm: AlarmBox.box.get(cmd.id), time: DateTime.now().add(const Duration(days:7)), doThingsWhenInvoke: InvokeHandler.notifyAndSmartTurnOff);
    }
    print("AlarmIsolateHandler: $message");
  }
}