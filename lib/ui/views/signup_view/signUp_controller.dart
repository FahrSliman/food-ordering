import 'package:flutter/material.dart';
import 'package:food/core/data/repositories/user_repository.dart';
import 'package:food/core/enum/message_type.dart';
import 'package:food/core/services/base_controller.dart';
import 'package:food/ui/shared/custom_widget/custom_toast.dart';
import 'package:food/ui/views/login_view/login_view.dart';
import 'package:food/ui/views/signup_view/signup_view.dart';
import 'package:get/get.dart';

class SignUpController extends BaseController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  
  FileModel? selectedFile;
  bool showOptions=false;

  void login() {
    Get.to(
      LoginView());
  }
  void signUp() {
    runFutureFunction(
        function: 
        UserRepository()
            .register(
                email: emailController.text,
                password: passwordController.text,
                firstname: nameController.text,
                lastname: nameController.text,
                age: 12,
                photoPath: selectedFile!.path)
            .then((value) => value.fold(
                (l) => CustomToast.showMessage(
                    meassage: l, messageType: MessageType.REJECTED),
                (r) => CustomToast.showMessage(
                    meassage: 'registered successfully',
                    messageType: MessageType.SUCCESS))));
}
  }
