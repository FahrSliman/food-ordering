import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food/core/data/repositories/user_repository.dart';
import 'package:food/core/enum/message_type.dart';
import 'package:food/ui/shared/colors.dart';
import 'package:food/ui/shared/custom_widget/custom_button.dart';
import 'package:food/ui/shared/custom_widget/custom_text_field.dart';
import 'package:food/ui/shared/custom_widget/custom_toast.dart';
import 'package:food/ui/shared/utils.dart';
import 'package:food/ui/views/login_view/login_view.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final ImagePicker picker = ImagePicker();
  bool visible = false;
  late XFile? file = XFile('');
  FileModel? selectedFile;
  bool showOptions = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
              key: _formKey,
              child: ListView(children: [
                Center(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      InkWell(
                        onTap:
                            selectedFile == null || selectedFile!.path.isEmpty
                                ? () {
                                    setShowOPtion(true);
                                  }
                                : null,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.mainOrangeColor,
                          child: selectedFile == null
                              ? Icon(Icons.person)
                              : selectedFile!.path.isNotEmpty &&
                                      selectedFile!.type == FileType.FILE
                                  ? Icon(Icons.file_copy)
                                  : selectedFile!.path.isNotEmpty
                                      ? Image.file(File(selectedFile!.path))
                                      : Icon(Icons.person),
                        ),
                      ),
                      Visibility(
                          visible: selectedFile != null &&
                              selectedFile!.path.isNotEmpty,
                          child: InkWell(
                            onTap: () {
                              setShowOPtion(true);
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.mainBlueColor,
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: showOptions,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                        text: "camera".tr,
                        onPressed: () {
                          pickFile(FileType.CAMERA)
                              .then((value) => selectedFile = value);
                        },
                      ),
                      CustomButton(
                        text: "Gallery".tr,
                        onPressed: () {
                          pickFile(FileType.GALLERY)
                              .then((value) => selectedFile = value);
                        },
                      ),
                      CustomButton(
                        text:"File".tr ,
                        onPressed: () {
                          pickFile(FileType.FILE)
                              .then((value) => selectedFile = value);
                        },
                      ),
                      ElevatedButton(
                          onPressed: () {
                            pickFile(FileType.FILE)
                                .then((value) => selectedFile = value);
                          },
                          child: Text(''))
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      top: size.width * 0.15, bottom: size.width * 0.03),
                  child: Text("signup".tr,
                      style: TextStyle(
                          color: AppColors.maingreyColor,
                          fontSize: size.width * 0.089)),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: size.width * 0.08),
                  child: Text("details".tr,
                      style: TextStyle(
                          color: Colors.grey, fontSize: size.width * 0.03)),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                      bottom: size.width * 0.07),
                  child: CustomTextField(
                    hintText: "name".tr,
                    controller: nameController,
                    validator: (value) {
                      return value!.isEmpty ?"check_name".tr  : null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                      bottom: size.width * 0.07),
                  child: CustomTextField(
                    hintText: "email_field".tr ,
                    controller: emailController,
                    validator: (value) {
                      return value!.isEmpty || !isEmail(value)
                          ? "check_email".tr
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                      bottom: size.width * 0.07),
                  child: CustomTextField(
                      hintText: "mobile".tr, controller: mobileNoController),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                      bottom: size.width * 0.07),
                  child: CustomTextField(
                      hintText: "Address".tr, controller: addressController),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                      bottom: size.width * 0.07),
                  child: CustomTextField(
                    hintText:"pass_field".tr,
                    controller: passwordController,
                    validator: (value) {
                      return value!.isEmpty || !isPassword(value)
                          ? "check_pass".tr
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                      bottom: size.width * 0.07),
                  child: CustomTextField(
                    hintText: "confirmPass".tr,
                    controller: confirmPasswordController,
                    // ignore: body_might_complete_normally_nullable
                    validator: (value) {
                      if (value!.isEmpty)
                        return "entervalue".tr;
                      else if (value != passwordController.text) return "check_pass".tr;
                    },
                  ),
                ),
                isLoading
                    ? SpinKitCircle(
                        color: AppColors.mainOrangeColor,
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                            bottom: size.width * 0.07, top: size.width * 0.05),
                        child: CustomButton(
                            text: "signup".tr,
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                              });
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
                                         
                                          meassage: l,
                                          messageType: MessageType.REJECTED),
                                      (r) => CustomToast.showMessage(
                                         
                                          meassage: "succefulregister".tr,
                                          messageType: MessageType.SUCCESS)));

                              // if (_formKey.currentState!.validate()) {
                              //   print('Every thing ok');
                              //   Navigator.pushReplacement(context,
                              //       MaterialPageRoute(
                              //     builder: (context) {
                              //       return MainView();
                              //     },
                              //   ));

                              //   setState(() {
                              //     isLoading = true;
                              //   });
                              //   Future.delayed(Duration(seconds: 3))
                              //       .then((value) => setState(() {
                              //             isLoading = false;
                              //           }));
                              // } else {
                              //   print(':(');
                              // }
                            }
                            ),
                      ),

                CustomButton(
                    text: "click".tr,
                    onPressed: () async {
                      final Uri _url = Uri.parse('https://flutter.dev');
                      if (!await launchUrl(_url,
                          mode: LaunchMode.externalApplication)) {
                        CustomToast.showMessage(
                          
                            meassage: "can_not".tr,
                            messageType: MessageType.REJECTED);
                      }
                    }),
                // dont need in our project

                Padding(
                  padding: EdgeInsets.only(bottom: size.width * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "have_account",
                        style: TextStyle(
                            color: AppColors.maingreyColor,
                            fontSize: size.width * 0.03),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return LoginView();
                            },
                          ));
                        },
                        child: Text(
                          "key_login",
                          style: TextStyle(
                            color: AppColors.mainOrangeColor,
                            fontSize: size.width * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            )));
  }

  void setShowOPtion(bool value) {
    setState(() {
      showOptions = value;
    });
  }

  Future<FileModel> pickFile(FileType type) async {
    String path = '';

    switch (type) {
      case FileType.CAMERA:
        await picker
            .pickImage(source: ImageSource.camera)
            .then((value) => path = value?.path ?? '');
        break;
      case FileType.GALLERY:
        await picker
            .pickImage(source: ImageSource.gallery)
            .then((value) => path = value?.path ?? '');
        break;
      case FileType.FILE:
        await FilePicker.platform
            .pickFiles()
            .then((value) => path = value?.paths[0] ?? '');
        break;
    }
    setShowOPtion(false);
    return FileModel(path.isNotEmpty ? path : selectedFile!.path,
        path.isNotEmpty ? type : selectedFile!.type);
  }
}

class FileModel {
  FileType type;
  String path;

  FileModel(this.path, this.type);
}

enum FileType { CAMERA, GALLERY, FILE }
