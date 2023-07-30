import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food/core/data/models/apis/meal_model.dart';
import 'package:food/ui/shared/colors.dart';
import 'package:food/ui/views/cart_view/cart_view.dart';
import 'package:food/ui/views/meal_details/meal_deails_controller.dart';
import 'package:get/get.dart';

class MealDetailsView extends StatefulWidget {
  const MealDetailsView({
    Key? key,
    required this.model,
  }) : super(key: key);
  final MealModel model;

  @override
  State<MealDetailsView> createState() => _MealDetailsViewState();
}

class _MealDetailsViewState extends State<MealDetailsView> {
  late MealDetailsController controller;
  @override
  void initState() {
    controller = Get.put(MealDetailsController(widget.model));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      bottom: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(() {
          return Stack(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.4,
                child: Image.asset('images/photo_2023-07-04_07-06-19.jpg',
                    width: size.width, fit: BoxFit.cover),
              ),
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                      top: size.width * 0.05,
                      start: size.width * 0.05,
                      end: size.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_back_ios, color: Colors.white),
                      Icon(Icons.shopping_cart, color: Colors.white),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(top: 20.0),
                      child: Container(
                        width: size.width,
                        height: size.height * 0.7,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(50),
                            topStart: Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      end: size.width * 0.05,
                      top: size.width * -0.012,
                      child:Image.asset('images/photo_2023-07-04_07-06-11.jpg'),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: size.width * 0.1,
                          start: size.width * 0.05,
                          end: size.width * 0.03),
                      child: Container(
                        height: size.height * 0.7,
                        width: size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tandoori Chicken Pizza',
                              style: TextStyle(
                                  color: AppColors.mainTextColor,
                                  fontSize: size.width * 0.05),
                            ),
                            SizedBox(height: size.width * 0.015),
                            RatingBar.builder(
                              updateOnDrag: true,
                              itemSize: size.width * 0.05,
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: AppColors.mainOrangeColor,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('3 Star Ratings',
                                    style: TextStyle(
                                        color: AppColors.mainOrangeColor,
                                        fontSize: size.width * 0.028)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${widget.model.price}',
                                      style: TextStyle(
                                        color: AppColors.mainTextColor,
                                        fontSize: size.width * 0.06,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '/ per Portion',
                                      style: TextStyle(
                                          fontSize: size.width * 0.03),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              'Description',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text(
                              '${widget.model.description}',
                              style: TextStyle(color: AppColors.mainTextColor),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Divider(
                              color: AppColors.mainTextColor,
                              thickness: size.width * 0.001,
                            ),
                            SizedBox(height: size.height * 0.1),
                            Row(
                              children: [
                                Text(
                                  'Number of Portions',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.04),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: controller.count.value == 1
                                      ? null
                                      : () {
                                          controller.changeCount(false);
                                        },
                                  child: Container(
                                    width: size.width * 0.15,
                                    height: size.height * 0.04,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: controller.count == 1
                                          ? AppColors.mainTextColor
                                          : AppColors.mainOrangeColor,
                                    ),
                                    child: Center(
                                        child: Text(
                                      '-',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: size.width * 0.01,
                                      end: size.width * 0.01),
                                  child: Container(
                                    width: size.width * 0.15,
                                    height: size.height * 0.04,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: AppColors.mainOrangeColor)),
                                    child: Center(
                                        child: Text(
                                      controller.count.value.toString(),
                                      style: TextStyle(
                                          color: AppColors.mainOrangeColor),
                                    )),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.changeCount(true);
                                  },
                                  child: Container(
                                    width: size.width * 0.15,
                                    height: size.height * 0.04,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: AppColors.mainOrangeColor,
                                    ),
                                    child: Center(
                                        child: Text(
                                      '+',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.only(top: size.width * 1.05),
                      child: Stack(
                        children: [
                          Container(
                            width: size.width * 0.2,
                            height: size.height * 0.2,
                            decoration: BoxDecoration(
                              color: AppColors.mainOrangeColor,
                              borderRadius: BorderRadiusDirectional.only(
                                topEnd: Radius.circular(25),
                                bottomEnd: Radius.circular(25),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                top: size.width * 0.055,
                                start: size.width * 0.05),
                            child: Container(
                              width: size.width * 0.8,
                              height: size.height * 0.14,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadiusDirectional.only(
                                  topStart: Radius.circular(25),
                                  bottomStart: Radius.circular(25),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(1, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: size.height * 0.01),
                                  Text(
                                    'Total Price',
                                    style: TextStyle(
                                        color: AppColors.mainTextColor),
                                  ),
                                  SizedBox(height: size.height * 0.005),
                                  Text(
                                    'LKR ' + controller.calcTotal().toString(),
                                    style: TextStyle(
                                        fontSize: size.width * 0.06,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      controller.addToCart();
                                      Get.to(() => CartView());
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add_shopping_cart,
                                          size: size.width * 0.05,
                                        ),
                                        SizedBox(width: size.width * 0.04),
                                        Text(
                                          'Check Offers',
                                          style: TextStyle(
                                              fontSize: size.width * 0.03),
                                        ),
                                      ],
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.mainOrangeColor,
                                        shape: StadiumBorder(),
                                        fixedSize: Size(size.width * 0.4,
                                            size.height * 0.02)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: size.width * 0.8,
                                top: size.width * 0.12),
                            child: Container(
                              width: size.width * 0.1,
                              height: size.height * 0.05,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(1, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.shopping_cart,
                                color: AppColors.mainOrangeColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
