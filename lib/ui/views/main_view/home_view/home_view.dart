import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/colors.dart';
import '../../../shared/custom_widget/shimmer_widget.dart';
import '../../../shared/utils.dart';
import '../../meal_details/meal_details.dart';
import 'home_controller.dart';

class HomePageView extends StatefulWidget {
  final Function onPressed;

  HomePageView({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {

  HomePageController controller = Get.put(HomePageController());


  @override
  Widget build(BuildContext context) {

    var now = DateTime.now();
    var hour = now.hour;

    String greeting = '';

    if (hour < 12) {
      greeting = 'good morning';
    } else if (hour > 12 && hour < 18) {
      greeting = 'good afternoon';
    } else {
      greeting = 'good evening';
    }



    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.deepOrange[600]!));

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: Icon(Icons.drag_handle , color: Colors.transparent,),
            flexibleSpace: Padding(
              padding: EdgeInsetsDirectional.only(top: screenWidth(25) , start: screenWidth(25)),
              child: Text(
                '$greeting Akila!',
                style: TextStyle(fontSize: screenWidth(20) ,color: AppColors.mainTextColor),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsetsDirectional.only(end: screenWidth(25)),
                child: Padding(
                  padding: EdgeInsets.only(top: screenWidth(50)),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Icon(Icons.shopping_cart , color: AppColors.mainTextColor,size: screenWidth(12),),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: screenWidth(20),
                          width: screenWidth(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.red
                          ),
                          child: Obx(() {
                            print(
                                controller.categoryList.length);
                            return
                              Center(child: Text('${cartService.cartCount}'));

                          })
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          drawer: Container(
            color: AppColors.mainRedColor,
          ),
          body:  Padding(
                  padding: EdgeInsetsDirectional.symmetric(vertical: screenWidth(40)),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: screenWidth(30)),
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: screenWidth(30)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Delivering to',
                                style: TextStyle(
                                    color: AppColors.maingreyColor,
                                    fontSize: screenWidth(30)),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Current Location',
                                    style: TextStyle(
                                      color: AppColors.mainTextColor,
                                      fontSize: screenWidth(20),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: screenWidth(50)),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.mainOrangeColor,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: screenWidth(35)),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsetsDirectional.symmetric(
                              horizontal: screenWidth(30),
                              vertical: screenWidth(50)),
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: screenWidth(30),
                              vertical: screenWidth(50)),
                          height: screenWidth(9),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey[200],
                          ),
                          child: TextField(
                            cursorColor: AppColors.mainTextColor,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.search,
                                color: AppColors.mainTextColor,
                              ),
                              hintText: "Search food",
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: screenWidth(30)),

                        Obx((){
                          return controller.isCategoryLoading
                              ? buildShimmer1()
                              : controller.categoryList.isEmpty
                              ? Text('No Category') : SizedBox(
                                  height: screenWidth(3.2),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: controller.categoryList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional.only(start: screenWidth(30), end: screenWidth(40)),
                                            child: Container(
                                              width: screenWidth(5.2),
                                              height: screenWidth(5.2),
                                              child: CachedNetworkImage(
                                                imageUrl: 'https://insanelygoodrecipes.com/wp-content/uploads/2020/02/Burger-and-Fries.webp',
                                                placeholder: (context, url) => CircularProgressIndicator(),
                                                errorWidget: (context, url, error) => Icon(Icons.error),
                                                imageBuilder: (context, imageProvider) => Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(controller.categoryList[index].name ?? '' , style: TextStyle(fontSize: screenWidth(20)),),
                                        ],
                                      );
                                    },
                                  ),
                                );}
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                              vertical: screenWidth(30),
                              horizontal: screenWidth(50)),
                          child: Row(
                            children: [
                              Text(
                                'Popular Restaurants',
                                style: TextStyle(fontSize: screenWidth(20)),
                              ),
                              Spacer(),
                              Text(
                                'View all',
                                style: TextStyle(
                                    fontSize: screenWidth(25),
                                    color: AppColors.mainOrangeColor),
                              ),
                            ],
                          ),
                        ),
                        Obx((){
                          return controller.isMealLoading
                              ? buildShimmer2() : controller.mealList.isEmpty
                              ? Text('No Meal')
                              : ListView.builder(
                                primary: false,
                                scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: controller.mealList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: screenWidth(2),
                                          child: InkWell(
                                            onTap: (){Get.to(MealDetailsView(model: controller.mealList[index],));},
                                            child: CachedNetworkImage(
                                              imageUrl: 'https://ichef.bbci.co.uk/food/ic/food_16x9_1600/recipes/breadandbutterpuddin_85936_16x9.jpg',
                                              placeholder: (context, url) => CircularProgressIndicator(),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(start: screenWidth(30) , top: screenWidth(50) , bottom: screenWidth(35)),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Text(controller.mealList[index].name ?? '', style: TextStyle(fontSize: screenWidth(22)),),

                                              Row(
                                                children: [
                                                  Icon(Icons.star, color: AppColors.mainOrangeColor, size: screenWidth(20),),

                                                  SizedBox(width: screenWidth(50)),

                                                  Text(controller.mealList[index].description ?? '', style: TextStyle(fontSize: screenWidth(32)),),

                                                  SizedBox(width: screenWidth(40)),
                                                  
                                                  Spacer(),

                                                  Padding(
                                                    padding: EdgeInsetsDirectional.only(end: screenWidth(25)),
                                                    child: InkWell(
                                                      onTap: (){
                                                        controller.addToCart(
                                                            controller.mealList[index]);
                                                      },
                                                        child: Container(
                                                          width: screenWidth(10),
                                                            height: screenWidth(15),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(50),
                                                              color: AppColors.mainOrangeColor
                                                            ),
                                                            child: Center(
                                                                child: Text('+' , style: TextStyle(fontSize: screenWidth(15) , color: Colors.white),))
                                                        )
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );}
                        ),
                        SizedBox(height: screenWidth(4)),
                      ],
                    ),
                  ),
                )
      )
    );
  }

  Widget buildShimmer1() => Container(
        height: MediaQuery.of(context).size.height * 0.09,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsetsDirectional.only(start: 5, end: 5),
                child: Container(
                  child: ShimmerWidget.circular(
                    height: 70,
                    width: 75,
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              );
            }),
      );

  Widget buildShimmer2() => Padding(
        padding: EdgeInsetsDirectional.all(10.0),
        child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ShimmerWidget.circular(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: double.infinity,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(top: 10, start: 5),
                      child: ShimmerWidget.rectangular(
                        height: 10,
                        width: MediaQuery.of(context).size.width * 0.7,
                      ),
                    )),
          ]),
        ),
      );
}
