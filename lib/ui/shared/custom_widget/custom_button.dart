import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? textSize;
  final FontWeight? textFontWeight;
  final Color? borderColor;
  final Color? backgroundColor;
  final Function? onPressed;
  final String? svgName;
  

  const CustomButton({
    Key? key,
    required this.text,
    this.textColor,
    this.textSize,
    this.textFontWeight,
    this.borderColor,
    this.backgroundColor,
     this.onPressed,
    this.svgName,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
        onPressed: () {
          if (onPressed != null) onPressed!();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (svgName != null) ...[
              SvgPicture.asset('images/$svgName.svg'),
              SizedBox(
                width: size.width * 0.02,
              )
            ],
            Text(
              text,
              style: TextStyle(
                  color: textColor ?? AppColors.mainWhiteColor,
                  fontSize: textSize ?? size.width * 0.04,
                  fontWeight: textFontWeight ?? FontWeight.normal),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
            side: borderColor != null
                ? BorderSide(
                    width: 1, color: borderColor ?? AppColors.mainOrangeColor)
                : null,
            backgroundColor: backgroundColor ?? AppColors.mainOrangeColor,
            shape: StadiumBorder(),
            fixedSize: Size(size.width*0.9, size.width * 0.14)));
  }
}
