import 'package:get/get.dart';
import '../../shared/utils.dart';
import '../landing_view/landing_view.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    if (storage.getOrderPlaced()) {
      cartService.clearCart();
      storage.setOrderPlaced(false);
    }
    Future.delayed(Duration(seconds: 5)).then((value) {
      if (storage.getFirstLunch()) {
        Get.off(IntroView());
      } else {
        Get.off(storage.getIsLoggedIn() ? LandingView() : LandingView());
      }
      //Get.back();
      storage.setFirstLunch(false);
    });
    super.onInit();
  }
}

class IntroView {
}