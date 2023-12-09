import 'dart:isolate';
import 'dart:ui';
import 'package:clockie/model/command_message.dart';
import 'notification/notification_vault.dart';
class InvokeHandler{
  ///@pragma('vm:entry-point')不是表明他会在另一个独立的isolate运行，
  ///但是确实他就是在另一个独立的isolate运行，这是android_alarm_manager_plus的api决定
  ///不同isolate的资源不能共享，不要妄图使用静态或全局变量或者参数传递来共享，行不通，只能通过以下的消息传递。
  ///该消息会被AlarmIsolateHandler::onData拿到
  @pragma('vm:entry-point')
  static void notifyAndSmartTurnOff(int id,Map<String, dynamic>params){
    bool isOnce=params['isOnce']??false;
    if(isOnce){
      SendPort? sendPort = IsolateNameServer.lookupPortByName(params['portName']);
      sendPort?.send(CommandMessage(cmdCode: 0, id: params['id']).toString());
    }
    NotificationVault.showAlarmNotification(id,params);
  }
}
