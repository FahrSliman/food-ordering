import 'package:flutter/material.dart';
import 'package:food/ui/shared/custom_widget/custom_button.dart';
import 'package:get/get.dart';
import '../../shared/colors.dart';
import '../../shared/utils.dart';
import 'cart_controller.dart';

class CartView extends StatefulWidget {
  CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  CartController controller = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.arrow_back_ios,
            color: AppColors.mainTextColor,
          ),
          title: Text(
            'My Order',
            style: TextStyle(color: AppColors.mainTextColor),
          ),
          elevation: 0,
        ),
        body: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenWidth(10),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: controller.cartList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        height: screenWidth(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  controller.removeFromCart(
                                      controller.cartList[index]);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red.withOpacity(0.6),
                                )),
                            Text(
                              controller.cartList[index].mealModel?.name ?? '',
                              style: TextStyle(fontSize: screenWidth(25)),
                            ),
                            Text(
                              '  x ' +
                                  controller.cartList[index].count.toString(),
                              style: TextStyle(fontSize: screenWidth(20)),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                controller.changeCount(
                                    false, controller.cartList[index]);
                              },
                              child: Container(
                                width: screenWidth(12),
                                height: screenWidth(12),
                                child: Center(
                                    child: Text('-',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: screenWidth(15)))),
                                decoration: BoxDecoration(
                                    color: AppColors.mainOrangeColor,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: screenWidth(50), end: screenWidth(50)),
                              child: Text(
                                controller.cartList[index].count.toString(),
                                style: TextStyle(fontSize: screenWidth(20)),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.changeCount(
                                    true, controller.cartList[index]);
                              },
                              child: Container(
                                width: screenWidth(12),
                                height: screenWidth(12),
                                child: Center(
                                    child: Text(
                                  '+',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth(15)),
                                )),
                                decoration: BoxDecoration(
                                    color: AppColors.mainOrangeColor,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                            SizedBox(width: screenWidth(50)),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: screenWidth(100), bottom: screenWidth(100)),
                    child: Container(
                      width: screenWidth(1),
                      height: 2,
                      color: AppColors.maingreyColor,
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                    top: screenWidth(10), start: screenWidth(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Sub Total : ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth(20)),
                        ),
                        Spacer(),
                        Text(
                          '${cartService.subTotal.value.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: AppColors.mainOrangeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth(20)),
                        ),
                        SizedBox(width: screenWidth(20)),
                      ],
                    ),
                    SizedBox(height: screenWidth(30)),
                    Row(
                      children: [
                        Text('Tax : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth(20))),
                        Spacer(),
                        Text('${cartService.tax.value.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: AppColors.mainOrangeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth(20))),
                        SizedBox(width: screenWidth(20)),
                      ],
                    ),
                    SizedBox(height: screenWidth(30)),
                    Row(
                      children: [
                        Text('Delivery : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth(20))),
                        Spacer(),
                        Text('${cartService.delivery.value.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: AppColors.mainOrangeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth(20))),
                        SizedBox(width: screenWidth(20)),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          start: screenWidth(20),
                          end: screenWidth(20),
                          top: screenWidth(30)),
                      child: Divider(
                        color: AppColors.mainBlackColor,
                      ),
                    ),
                    SizedBox(height: screenWidth(40)),
                    Row(
                      children: [
                        Text('Total : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth(20))),
                        Spacer(),
                        Text('${cartService.total.value.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: AppColors.mainOrangeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth(20))),
                        SizedBox(width: screenWidth(20)),
                      ],
                    ),
                    CustomButton(
                      text: 'Checkout',
                      onPressed: () {
                        controller.checkout();
                      },
                    )
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
