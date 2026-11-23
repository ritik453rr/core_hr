import 'package:core_hr/core/services/notification_service/push_notification_model.dart';
import 'package:get/get.dart';

import '../../../feature/dashboard/presentation/controller/dashboard_controller.dart';

/// Routes push notifications to the appropriate app flow based on their type.
class NotificationRouter {
  static void redirect(PushNotificationModel value) {
    if (!Get.isRegistered<DashboardController>()) {
      return;
    }

  }
}
