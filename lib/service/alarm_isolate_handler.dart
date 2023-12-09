import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:clockie/model/command_message.dart';
import 'package:clockie/service/provider/penthhouse_provider.dart';
import 'package:tuple/tuple.dart';

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
    if(cmd.cmdCode==0) {
      if(PenthHouseProviders.alarmProvider==null)throw Exception('AlarmIsolateHandler: alarmProvider is not initialized');
      PenthHouseProviders.alarmProvider!.turnOffAlarm(cmd.id);
    }
    print("AlarmIsolateHandler: $message");
  }
}