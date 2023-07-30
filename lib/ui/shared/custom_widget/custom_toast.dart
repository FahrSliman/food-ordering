import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food/core/enum/message_type.dart';
import 'package:food/ui/shared/colors.dart';
import 'package:food/ui/shared/utils.dart';

class CustomToast {
  static showMessage(
      {required String meassage, MessageType messageType = MessageType.INFO}) {
    String imageName = 'info';
    Color shadowColor = AppColors.mainOrangeColor;

    switch (messageType) {
      case MessageType.INFO:
        imageName = 'info';
        shadowColor = AppColors.mainOrangeColor;
        break;
      case MessageType.WARNING:
        imageName = 'warning';
        shadowColor = AppColors.mainWhiteColor;
        break;
      case MessageType.REJECTED:
        imageName = 'rejected-01';
        shadowColor = AppColors.maingreyColor;
        break;
      case MessageType.SUCCESS:
        imageName = 'approved1-01';
        shadowColor = AppColors.mainOrangeColor;
        break;
    }
    BotToast.showCustomText(
        duration: Duration(seconds: 3),
        toastBuilder: (value) {
          return Container(
            width: screenWidth(5),
            height: screenWidth(5),
            decoration: BoxDecoration(
                color: AppColors.mainWhiteColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'images/$imageName.svg',
                  width: screenWidth(5),
                  height: screenWidth(5),
                ),
                SizedBox(height: screenWidth(5)),
                Text(
                  meassage,
                  style: TextStyle(
                    fontSize: screenWidth(5),
                    color: AppColors.mainOrangeColor,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
