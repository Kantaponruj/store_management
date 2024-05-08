import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:store_management/constants/firebase_auth_constants.dart';
import 'package:store_management/screens/components/custom_button.dart';
import 'package:store_management/screens/components/custom_text_fields.dart';
import 'package:store_management/shared/theme/color_theme.dart';
import 'package:store_management/shared/theme/text_theme.dart';
import 'package:store_management/utils/validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final context = Get.context!;

    final size = MediaQuery.of(context).size;

    bool isValidate = _formKey.currentState?.validate() ?? false;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorTheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              surfaceTintColor: Colors.transparent,
              margin: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: () {
                  setState(() {});
                  debugPrint("isValidate: $isValidate");
                },
                child: Container(
                  width: context.isPhone ? size.width : size.width * 0.4,
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Save login data into get storage
                      SizedBox(
                        height: 200,
                        child: SvgPicture.asset("assets/images/svg/login.svg"),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.center,
                        child: Text("เข้าสู่ระบบ",
                            style: CustomTextTheme.titleBold.copyWith(
                              color: ColorTheme.primary,
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        alignment: Alignment.center,
                        child: Text(
                          "เข้าสู่ระบบด้วยอีเมลและรหัสผ่าน",
                          style: CustomTextTheme.subtitle,
                        ),
                      ),
                      CustomTextField(
                        props: CustomTextFieldProps(
                          topic: "อีเมล",
                          controller: _emailController,
                          hintText: "กรุณาใส่อีเมลร้านค้า",
                          textInputAction: TextInputAction.next,
                          validator: Validators.compose([
                            Validators.required("กรุณาใส่อีเมลร้านค้า"),
                            Validators.email("กรุณาใส่อีเมลร้านค้าให้ถูกต้อง"),
                          ]),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: CustomTextField(
                          props: CustomTextFieldProps(
                            topic: "รหัสผ่าน",
                            controller: _passwordController,
                            hintText: "กรุณาใส่รหัสผ่านร้านค้า",
                            type: TextFieldType.password,
                            textInputAction: TextInputAction.done,
                            validator: Validators.compose([
                              Validators.required("กรุณาใส่รหัสผ่านร้านค้า"),
                              Validators.minLength(
                                6,
                                "กรุณาใส่รหัสผ่านร้านค้าให้มากกว่า 6 ตัวอักษร",
                              ),
                            ]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        isLoading: authController.isLoadingLogin.value,
                        buttonName: "เข้าสู่ระบบ",
                        onPressed: isValidate
                            ? () async {
                                bool validate =
                                    _formKey.currentState!.validate();

                                String email = _emailController.text.trim();
                                String password =
                                    _passwordController.text.trim();

                                debugPrint(
                                    "email: $email, password: $password");

                                setState(() {});

                                if (validate == true) {
                                  authController.login(email, password);
                                }
                              }
                            : null,
                        icon: Icons.login_rounded,
                      ),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Colors.red,
                      //   ),
                      //   onPressed: () {
                      //     authController.signInWithGoogle();
                      //   },
                      //   child: const Text("Sign In with Google"),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
