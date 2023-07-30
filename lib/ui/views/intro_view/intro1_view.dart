import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:food/ui/shared/custom_widget/custom_button.dart';
import 'package:food/ui/views/landing_view/landing_view.dart';
import 'package:get/get.dart';

class Intro1View extends StatefulWidget {
  const Intro1View({super.key});

  @override
  State<Intro1View> createState() => _Intro1ViewState();
}

class _Intro1ViewState extends State<Intro1View> {
  List<String> titleList = [
    "title1".tr,
    "title2".tr,
    "title3".tr,
    
    
  ];
  List<String> descriptionList = [
    "firstTextforintro".tr,
    "secondTextforintro".tr,
    "thirdTextforintro".tr,
  ];
  List<String> imageList = ['intro0.svg', 'intro1.svg', 'intro2.svg'];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.width * 0.07, horizontal: size.width * 0.05),
          child: Column(
            children: [
              SvgPicture.asset('images/intro$currentIndex.svg'),
              Padding(
                padding: EdgeInsets.only(
                    top: size.width * 0.05, bottom: size.width * 0.1),
                child: DotsIndicator(
                  dotsCount: 3,
                  position: currentIndex.toDouble(),
                  decorator: DotsDecorator(
                    color: Colors.grey,
                    activeColor: Colors.black,
                  ),
                ),
              ),
              Text(
                titleList[currentIndex],
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: size.width * 0.06),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.width * 0.05, bottom: size.width * 0.1),
                child: Text(
                  descriptionList[currentIndex],
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(),
              CustomButton(
                  text: currentIndex != 2 ? 'Next' : 'Finish',
                  onPressed: () {
                    if (currentIndex != 2) {
                      setState(() {
                        currentIndex = currentIndex + 1;
                      });
                    } else {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return LandingView();
                      }));
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
