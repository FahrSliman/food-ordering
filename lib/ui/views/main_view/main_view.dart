import 'package:flutter/material.dart';
import 'package:food/core/enum/bottom_navigation.dart';
import 'package:food/ui/shared/custom_widget/custom_drawer.dart';
import 'package:food/ui/views/main_view/home_view/home_view.dart';
import 'package:food/ui/views/main_view/menu_view/menu_view.dart';
import 'package:food/ui/views/main_view/more_view/more_view.dart';
import 'package:food/ui/views/main_view/offers_view/offers_view.dart';
import 'package:food/ui/views/main_view/profile_view/profile_view.dart';

import 'main_view_widgets/bottom_navigation_widget.dart';



class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  TextEditingController searchController = TextEditingController();

  BottomNavigationEnum select = BottomNavigationEnum.HOME;
  PageController controller = PageController(initialPage: 2);

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      // bottom: true,
      // maintainBottomViewPadding: true,
      child: Scaffold(
        key: key,
        drawer: CustomDrawer(),
        resizeToAvoidBottomInset: false,
       // extendBody: true,
       // extendBodyBehindAppBar: true,
       // primary: false,
       // backgroundColor: Colors.black.withOpacity(0.9),
        body: Stack(
          children: [
            PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                MenuView(),
                OffersView(),
                HomePageView(onPressed: (){key.currentState!.openDrawer();},),
                ProfileView(),
                MoreView(),
              ],
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: BottomNavigationWidget(
                bottomNavigation: select,
                onTap: (selected , pageNumber ) {
                  // key.currentState!.openDrawer();
                  setState(() {
                    select = selected;
                  }
                  );
                  controller.jumpToPage(pageNumber);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}