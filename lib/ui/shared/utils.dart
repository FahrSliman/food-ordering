import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food/core/data/repositories/shared_preferences_repositories.dart';
import 'package:food/core/services/cart_services.dart';
import 'package:food/core/services/location_service.dart';
import 'package:food/ui/shared/colors.dart';
import 'package:get/get.dart';
import '../../app/myapp_controller.dart';
import '../../core/enum/connectivity_status.dart';
import '../../core/enum/message_type.dart';
import '../../core/services/connectivity_service.dart';
import '../../core/services/notification_service.dart';
import 'custom_widget/custom_toast.dart';

bool isEmail(String value) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(value);
}

bool isPassword(String value) {
  String p = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(value);
}

double screenWidth(double percent) {
  return Get.size.width / percent;
}

double screenHeight(double percent) {
  return Get.size.height / percent;
}

SharedPreferencesRepositories get storage =>
    Get.find<SharedPreferencesRepositories>();

CartService get cartService => Get.find<CartService>();
LocationService get locationService => Get.find<LocationService>();
ConnectivityService get connectivityService => Get.find<ConnectivityService>();
NotificationService get notificationService => Get.find<NotificationService>();

bool get isOnline =>
    Get.find<MyAppController>().connectionStatus == ConnectivityStatus.ONLINE;

void fadeInTransition(Widget view) {
  Get.to(view, transition: Transition.fadeIn);
}

void customLoader() => BotToast.showCustomLoading(toastBuilder: (builder) {
      return Container(
        width: screenWidth(5),
        height: screenWidth(5),
        decoration: BoxDecoration(
            color: AppColors.mainWhiteColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(15)),
        child: SpinKitCircle(color: AppColors.mainOrangeColor),
      );
    });

double get taxAmount => 0.18;
double get deliveryAmount => 0.1;

void checkConnection(Function function) {
  if (isOnline)
    function();
  else
    CustomToast.showMessage(
        meassage: 'Please check internet connection',
        messageType: MessageType.WARNING);
}
