import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:clockie/gui/widget/generic/custom_alert.dart';
import 'package:clockie/util/formattor.dart';
import 'package:flutter/cupertino.dart';

import 'notification_service.dart';

class NotificationVault {
  static void showAlarmFullNotification(int id,Map<String, dynamic>params)async {
    NotificationService.showNotification(title: "Alarm ${params['name']}", body: '${params['desc']}',
        category: NotificationCategory.Alarm,actionType: ActionType.KeepOnTop,
        actionButtons: [NotificationActionButton(key: NotificationKeyFormattor.makeKey(id, NotifOper.stop), label: "Stop")]);
  }
  static void showTimeExpiryNotification(BuildContext context){
    showSimpleSnackBar(context, "The timer has expired");
    NotificationService.showNotification(title: "Timer", body: "The timer has expired");
  }
}