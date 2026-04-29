import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppNavigatorLogger {
  static List<NavigatorObserver> observers() => [
    GetObserver((routing) {
      if (routing == null) return;
      Get.log(
        '[NAV] current=${routing.current} previous=${routing.previous}'
        'isBack=${routing.isBack} isBottomSheet=${routing.isBottomSheet} isDialog=${routing.isDialog}',
      );
    }),
  ];

  static void Function(Routing?) routingCallback() => (routing) {
    if (routing == null) return;
    Get.log(
      '[ROUTING] current=${routing.current} previous=${routing.previous}',
    );
  };
}
