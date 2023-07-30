import 'package:flutter/material.dart';
import 'package:food/ui/shared/custom_widget/custom_button.dart';
import 'package:get/get.dart';
import '../../shared/utils.dart';
import '../main_view/main_view.dart';
import 'checkout_controller.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {

  CheckoutController controller = Get.put(CheckoutController());

  @override
  void initState() {
    storage.setOrderPlaced(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      //  WillPopScope(
      //     child:
      SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Text(
                  'sub Total: ${cartService.subTotal.value}',
                  style: TextStyle(fontSize: screenWidth(10)),
                ),
                Text(
                  'Tax: ${cartService.tax.value}',
                  style: TextStyle(fontSize: screenWidth(10)),
                ),
                Text(
                  'Delivery: ${cartService.delivery.value}',
                  style: TextStyle(fontSize: screenWidth(10)),
                ),
                Text(
                  'Total: ${cartService.total.value}',
                  style: TextStyle(fontSize: screenWidth(10)),
                ),
                CustomButton(
                  text: 'Continue shopping',
                  onPressed: () {
                    cartService.clearCart();
                    Get.off(MainView());
                  },
                )
              ],
            ),
          ));
    // onWillPop: () async {
    //   cartService.clearCart();
    //   Get.off(MainView());

    //   return false;
    // });
  }
}
