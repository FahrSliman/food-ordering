import 'package:get/get.dart';
import '../../../core/data/models/cart_model.dart';
import '../../../core/services/base_controller.dart';
import '../../shared/utils.dart';
import '../checkout_view/checkout_view.dart';

class CartController extends BaseController {
  List<CartModel> get cartList => cartService.cartList;

  void removeFromCart(CartModel model) {
    cartService.removeFromCart(
      model: model,
    );
  }

  void changeCount(bool increase, CartModel model) {
    cartService.changeCount(
      incress: increase,
      model: model,
    );
  }

  void checkout() {
    runFullLoadingFunction(
        function: Future.delayed(Duration(seconds: 2)).then((value) {
          Get.off(CheckoutView());
        }));
  }
}