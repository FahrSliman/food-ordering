import 'package:flutter/material.dart';
import 'package:food/core/data/repositories/user_repository.dart';
import 'package:food/core/enum/message_type.dart';
import 'package:food/core/services/base_controller.dart';
import 'package:food/ui/shared/utils.dart';
import 'package:food/ui/views/main_view/main_view.dart';
import 'package:get/get.dart';
import '../../shared/custom_widget/custom_toast.dart';

class LoginController extends BaseController {
  TextEditingController emailController = TextEditingController(text: 'Test@gmail.com');
  TextEditingController passwordController = TextEditingController(text: 'Test@1234');

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  void login() {
    // if (formKey.currentState!.validate()) {
    runFullLoadingFunction(
        function: UserRepository()
            .login(
            email: emailController.text, password: passwordController.text)
            .then((value) {
          value.fold((l) {
            CustomToast.showMessage(meassage: l, messageType: MessageType.REJECTED);
          }, (r) {
            storage.setIsLoggedIn(true);
            storage.setTokenInfo(r);
            Get.off(MainView());
          });
        }));
  }
}