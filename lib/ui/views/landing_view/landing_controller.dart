import 'dart:ui';

import 'package:food/core/services/base_controller.dart';
import 'package:food/ui/views/login_view/login_view.dart';
import 'package:food/ui/views/signup_view/signup_view.dart';
import 'package:get/get.dart';

import '../../../core/enum/notification_type.dart';
import '../../shared/colors.dart';
import '../../shared/utils.dart';

class LandingController extends BaseController {
 Rx<Color> color = AppColors.mainOrangeColor.obs;
void LoginL(){
  Get.to(LoginView());
}
void CreateAccount(){
  Get.to(SignupView());

}
void onInit() {
    notificationService.notificationStream.stream.listen((event) {
      if (event.notificatioNType == NotificationType.CHANGECOLOR.name) {
        color.value = AppColors.mainBlueColor;
      }
    });
    super.onInit();
  }

}