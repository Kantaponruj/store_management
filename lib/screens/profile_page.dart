import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_management/controllers/auth_controller.dart';
import 'package:store_management/screens/components/custom_button.dart';
import 'package:store_management/screens/components/custom_text_fields.dart';
import 'package:store_management/shared/theme/color_theme.dart';
import 'package:store_management/shared/theme/text_theme.dart';
import 'package:store_management/utils/validator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isHoverImage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorTheme.primary,
      appBar: AppBar(
        title: Text(
          "ข้อมูลผู้ใช้งาน",
          style: CustomTextTheme.titleBold,
        ),
      ),
      body: SafeArea(
        child: GetX<AuthController>(
          init: AuthController(),
          builder: (controller) {
            final firebaseUser = controller.firebaseUser.value;

            if (firebaseUser != null) {
              nameController.text = firebaseUser.displayName ?? "";
              emailController.text = firebaseUser.email ?? "";
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: ColorTheme.white,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  constraints: const BoxConstraints(
                    maxWidth: 400,
                  ),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              const CircleAvatar(
                                backgroundColor: ColorTheme.background,
                                // foregroundImage: NetworkImage(
                                //   "https://avatars.githubusercontent.com/u/102711774?v=4",
                                // ),
                                maxRadius: 100,
                                child: Icon(
                                  Icons.person_rounded,
                                  size: 50,
                                  color: ColorTheme.primary,
                                ),
                              ),
                              isHoverImage
                                  ? CircleAvatar(
                                      backgroundColor:
                                          ColorTheme.black.withOpacity(0.5),
                                      // foregroundImage: NetworkImage(
                                      //   "https://avatars.githubusercontent.com/u/102711774?v=4",
                                      // ),
                                      maxRadius: 100,
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.edit_rounded,
                                            color: ColorTheme.white,
                                            // size: 15,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "แก้ไขรูปภาพ",
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          props: CustomTextFieldProps(
                              topic: "ชื่อ - นามสกุล",
                              controller: nameController,
                              validator: Validators.compose([
                                Validators.required("กรุณากรอกชื่อ - นามสกุล"),
                              ])),
                        ),
                        CustomTextField(
                          props: CustomTextFieldProps(
                            topic: "อีเมล",
                            controller: emailController,
                            enabled: false,
                          ),
                        ),
                        const Spacer(),
                        CustomButton(
                          buttonName: "บันทึก",
                          onPressed: () {
                            final isValidate = formKey.currentState!.validate();

                            if (isValidate) {
                              controller.updateProfile(nameController.text);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
