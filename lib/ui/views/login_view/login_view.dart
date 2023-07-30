import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food/app/my_app.dart';
import 'package:food/core/enum/request_status.dart';
import 'package:food/ui/shared/colors.dart';
import 'package:food/ui/shared/custom_widget/custom_button.dart';
import 'package:food/ui/shared/custom_widget/custom_text_field.dart';
import 'package:food/ui/shared/utils.dart';
import 'package:food/ui/views/login_view/login_controller.dart';
import 'package:food/ui/views/reset_password_view/reset_password_view.dart';
import 'package:get/get.dart';


class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController controller =Get.put(LoginController()) ;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.language,
                  ),
                  onPressed: () {
                    Get.defaultDialog(
                        title: 'Change Language',
                        content: Column(
                          children: [
                            TextButton(
                                onPressed: () {
                                  storage.setAppLanguage(
                                      'en');
                                  Get.updateLocale(getLocal());
                                  Get.back();
                                },
                                child: Text('English')),
                            TextButton(
                                onPressed: () {
                                  storage.setAppLanguage(
                                      'ar');
                                  Get.updateLocale(getLocal());
                                  Get.back();
                                },
                                child: Text('العربية')),
                          ],
                        ));
                  },
                ),
                SizedBox(
                  height: size.width * 0.25,
                ),
                Text(
                   "key_login".tr,
                  style: TextStyle(
                      fontSize: size.width * 0.07,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainBlackColor),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.width * 0.01, bottom: size.width * 0.1),
                  child: Text(
                    "login_details".tr,
                    style: TextStyle(
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.normal,
                        color: AppColors.mainTextColor),
                  ),
                ),
                CustomTextField(
                  hintText:  "email_field".tr,
                  controller: controller.emailController,
                  validator: (value) {
                    if (value!.isEmpty || !GetUtils.isEmail(value)) {
                      return  "check_email".tr ;
                    }
                  },
                ),
                SizedBox(
                  height: size.width * 0.05,
                ),
                CustomTextField(
                  hintText:  "pass_field".tr,
                  controller: controller.passwordController,
                  validator: (value) {
                    if (value!.isEmpty ) {
                      return  "check_password".tr;
                    }
                  },
                ),
                SizedBox(
                  height: size.width * 0.07,
                ),
                Obx(() {
                  return controller.requestStatus == RequestStatus.LOADING
                      ? SpinKitCircle(
                          color: AppColors.mainOrangeColor,
                        )
                      : CustomButton(
                          text: "key_login".tr,
                          onPressed: () {
                            controller.login();
                          });
                }),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.width * 0.06, bottom: size.width * 0.1),
                  child: InkWell(onTap: () => Get.to(ResetPassword()),
                    child: Text(
                     "Forget_pass".tr,
                      style: TextStyle(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.normal,
                          color: AppColors.mainTextColor),
                    ),
                  ),
                ),
                Text(
                   "or_login".tr,
                  style: TextStyle(
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.normal,
                      color: AppColors.mainTextColor),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.width * 0.06, bottom: size.width * 0.06),
                  child: CustomButton(
                    text:  "facebook".tr,
                    backgroundColor: AppColors.mainBlueColor,
                    svgName: 'Facebook',
                  ),
                ),
                CustomButton(
                  text:  "google".tr,
                  backgroundColor: AppColors.mainRedColor,
                  svgName: 'google-plus-logo',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
