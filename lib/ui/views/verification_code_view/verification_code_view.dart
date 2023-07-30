import 'package:flutter/material.dart';
import 'package:food/ui/shared/colors.dart';
import 'package:food/ui/shared/custom_widget/custom_button.dart';
import 'package:food/ui/views/login_view/login_view.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class VerrifyCode extends StatefulWidget {
  const VerrifyCode({super.key});

  @override
  State<VerrifyCode> createState() => _VerrifyCodeState();
}
TextEditingController textEditingController = TextEditingController();
String Completed = '1234';
class _VerrifyCodeState extends State<VerrifyCode> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(
              height: size.width * 0.05,
            ),
            Text('We have an OTP to',
                style: TextStyle(
                    color: AppColors.maingreyColor,
                    fontSize: size.width * 0.06)),
            Text(
              'your Mobile',
              style: TextStyle(
                  fontSize: size.width * 0.06, color: AppColors.maingreyColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.width * 0.06,
            ),
            Text(
              'please check your mobile number 071*****12 \n continue to reset your password',
              style: TextStyle(
                  color: AppColors.maingreyColor, fontSize: size.width * 0.04),
              textAlign: TextAlign.center,
            ),
            
            PinCodeTextField(
                  appContext: context,
                  length: 4,
                  cursorHeight: size.width * 0.06,
                  cursorWidth: size.width * 0.006,
                  cursorColor: AppColors.mainOrangeColor,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  keyboardType: TextInputType.number,
                  enableActiveFill: true,
                  hintCharacter: '*',
                  autoUnfocus: true,
                  hintStyle: TextStyle(
                      fontSize: size.width * 0.05,
                      color: AppColors.maingreyColor,
                      fontWeight: FontWeight.normal),
                  
                  onChanged: (String value) {},
                  pinTheme: PinTheme(
                    activeColor: AppColors.mainOrangeColor,
                    inactiveColor: AppColors.maingreyColor,
                    selectedColor: AppColors.maingreyColor,
                    activeFillColor: AppColors.mainWhiteColor,
                    inactiveFillColor: AppColors.maingreyColor,
                    selectedFillColor: AppColors.maingreyColor,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(size.width * 0.04),
                    fieldHeight: size.width * 0.15,
                    fieldWidth: size.width * 0.15,
                    
                  ),
                  onCompleted: (value) {
                    if (value == Completed) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginView();
                      }));
                    }
                  }),
                
                  
            SizedBox(
              height: size.width * 0.07,
            ),
            Container(
              width: size.width * 0.8,
              height: size.width * 0.13,
              child: CustomButton(
                text: 'Next',
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: size.width * 0.08,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Didn\'t Receive ? ',
                  style: TextStyle(
                      color: AppColors.maingreyColor,
                      fontSize: size.width * 0.04),
                ),
                Text(
                  'Click Here',
                  style: TextStyle(
                    color: AppColors.mainOrangeColor,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
