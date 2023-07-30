import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food/core/enum/bottom_navigation.dart';
import 'package:food/ui/shared/colors.dart';
import 'package:food/ui/views/landing_view/landing_view.dart';

class BottomNavigationWidget extends StatefulWidget {
  final BottomNavigationEnum bottomNavigation;
  final Function(BottomNavigationEnum, int) onTap;
  BottomNavigationWidget(
      {Key? key, required this.bottomNavigation, required this.onTap})
      : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: size.width * 0.13),
          child: InkWell(
            onTap: () {
              widget.onTap(BottomNavigationEnum.HOME, 2);
            },
            child: CircleAvatar(
              radius: size.width * 0.1,
              backgroundColor:
                  widget.bottomNavigation == BottomNavigationEnum.HOME
                      ? AppColors.mainOrangeColor
                      : AppColors.mainGreyColor,
              child: SvgPicture.asset(
                'images/ic_home.svg',
                color: Colors.white,
              ),
            ),
          ),
        ),
        CustomPaint(
          painter: ClipShadowShadowPainter(
              shadow: Shadow(
                blurRadius: 12,
                offset: Offset(0, 1),
                color: AppColors.maingreyColor,
              ),
              clipper: BottomClip()),
          child: ClipPath(
            clipper: BottomClip(),
            child: Container(
              width: size.width,
              height: size.width * 0.23,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: size.width * 0.05,
          left: size.width * 0.05,
          right: size.width * 0.05,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    navItem(
                        size: size,
                        imageName: 'ic_menu',
                        text: 'Menu',
                        isSelected: widget.bottomNavigation ==
                            BottomNavigationEnum.MENU,
                        onTap: () {
                          widget.onTap(BottomNavigationEnum.MENU, 0);
                        }),
                    SizedBox(
                      width: size.width * 0.1,
                    ),
                    navItem(
                        size: size,
                        imageName: 'ic_shopping',
                        text: 'Offers',
                        isSelected: widget.bottomNavigation ==
                            BottomNavigationEnum.OFFERS,
                        onTap: () {
                          widget.onTap(BottomNavigationEnum.OFFERS, 1);
                        }),
                  ],
                ),
                Row(
                  children: [
                    navItem(
                        size: size,
                        imageName: 'ic_user',
                        text: 'Profile',
                        isSelected: widget.bottomNavigation ==
                            BottomNavigationEnum.PROFILE,
                        onTap: () {
                          widget.onTap(BottomNavigationEnum.PROFILE, 3);
                        }),
                    SizedBox(
                      width: size.width * 0.1,
                    ),
                    navItem(
                        size: size,
                        imageName: 'ic_more',
                        text: 'More',
                        isSelected: widget.bottomNavigation ==
                            BottomNavigationEnum.MORE,
                        onTap: () {
                          widget.onTap(BottomNavigationEnum.MORE, 4);
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget navItem({
    required Size size,
    required String imageName,
    required String text,
    required bool isSelected,
    required Function onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          SvgPicture.asset(
            'images/$imageName.svg',
            width: size.width * 0.06,
            color: isSelected
                ? AppColors.mainOrangeColor
                : AppColors.maingreyColor,
          ),
          SizedBox(height: size.width*0.01,),
          Text(text),
        ],
      ),
    );
  }
}

class BottomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width * 0.3381500, 0);
    path0.quadraticBezierTo(size.width * 0.3731500, size.height * 0.0069000,
        size.width * 0.3757000, size.height * 0.1236000);
    path0.quadraticBezierTo(size.width * 0.4022000, size.height * 0.5633000,
        size.width * 0.5006000, size.height * 0.5896000);
    path0.quadraticBezierTo(size.width * 0.5955500, size.height * 0.5727000,
        size.width * 0.6200000, size.height * 0.1240000);
    path0.quadraticBezierTo(size.width * 0.6204500, size.height * -0.0157000,
        size.width * 0.6646000, 0);
    path0.lineTo(size.width, 0);
    path0.lineTo(size.width, size.height);
    path0.lineTo(0, size.height);
    path0.lineTo(0, 0);
    path0.lineTo(size.width * 0.6225000, size.height * 0.6100000);
    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
