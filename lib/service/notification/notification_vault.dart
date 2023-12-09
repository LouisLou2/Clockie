import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:clockie/util/formattor.dart';

import 'notification_service.dart';

class NotificationVault {
  static void showAlarmNotification(int id,Map<String, dynamic>params)async {
    NotificationService.showNotification(title: "Alarm ${params['name']}", body: '${params['desc']}',
        category: NotificationCategory.Alarm,actionType: ActionType.KeepOnTop,
        actionButtons: [NotificationActionButton(key: NotificationKeyFormattor.makeKey(id, NotifOper.stop), label: "Stop")]);
  }
}