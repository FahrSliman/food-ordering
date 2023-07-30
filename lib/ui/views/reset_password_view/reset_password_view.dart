import 'package:flutter/material.dart';
import 'package:food/core/data/repositories/user_repository.dart';
import 'package:food/core/enum/message_type.dart';
import 'package:food/ui/shared/colors.dart';
import 'package:food/ui/shared/custom_widget/custom_button.dart';
import 'package:food/ui/shared/custom_widget/custom_text_field.dart';
import 'package:food/ui/shared/custom_widget/custom_toast.dart';
import 'package:food/ui/views/verification_code_view/verification_code_view.dart';
import 'package:get/get.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(top: size.width * 0.1),
          child: Column(
            children: [
              Text(
                "reset".tr,
                style: TextStyle(
                    color: AppColors.maingreyColor,
                    fontSize: size.width * 0.06),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.width * 0.04, bottom: size.width * 0.15),
                child: Text(
                  "receive".tr,
                  style: TextStyle(
                      color: Colors.grey, fontSize: size.width * 0.03),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.05,
                    right: size.width * 0.05,
                    bottom: size.width * 0.07),
                child: CustomTextField(
                    hintText: "email_field".tr , controller: emailController),
              ),
              CustomButton(
                text: "send".tr,
                onPressed: () {
                  UserRepository()
                      .ForgotPassword(email1: emailController.text)
                      .then((value) => value.fold(
                          (l) => CustomToast.showMessage(
                             
                              meassage: l,
                              messageType: MessageType.REJECTED),
                          (r) => Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return VerrifyCode();
                     }
                    )
                   )
                  )
                 );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}