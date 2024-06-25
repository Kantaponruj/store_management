import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:store_management/constants/constant.dart';
import 'package:store_management/constants/firebase_auth_constants.dart';
import 'package:store_management/screens/components/custom_button.dart';
import 'package:store_management/screens/components/custom_text_fields.dart';
import 'package:store_management/shared/layout/scroll_column.dart';
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
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorTheme.background,
      body: SafeArea(
        child: ScrollColumnExpandable(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: isPhone
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          color: ColorTheme.white,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: appLogo(),
                              ),
                              imageSection(size.width * 0.4),
                            ],
                          ),
                        ),
                        loginFormSection(),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: ColorTheme.white,
                            padding: const EdgeInsets.all(20),
                            height: size.height - 30,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                appLogo(),
                                Expanded(
                                  child: imageSection(size.height * 0.4),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: loginFormSection(),
                        )
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appLogo() {
    return Row(
      children: [
        Container(
          width: isPhone ? 50 : 80,
          padding: const EdgeInsets.only(right: 10),
          child: Image.asset(
            "assets/images/logo.png",
          ),
        ),
        Text(
          "Mile RMS",
          style: CustomTextTheme.titleBold.copyWith(
            fontSize: context.isPhone ? 20 : 30,
            color: ColorTheme.primary,
          ),
        ),
      ],
    );
  }

  Widget imageSection(double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: height,
          width: height,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: SvgPicture.asset(
              "assets/images/svg/login.svg",
            ),
          ),
        ),
      ],
    );
  }

  Widget loginFormSection() {
    final size = MediaQuery.of(context).size;

    return Container(
      width: context.isPhone ? size.width : size.width * 0.4,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: context.isPhone
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: context.isPhone ? 10 : 20),
            alignment: Alignment.centerLeft,
            child: Text("เข้าสู่ระบบ",
                style: CustomTextTheme.titleBold.copyWith(
                  fontSize: context.isPhone ? null : 30,
                  color: ColorTheme.primary,
                )),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              "เข้าสู่ระบบด้วยอีเมลและรหัสผ่าน",
              style: CustomTextTheme.subtitle,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CustomTextField(
                  props: CustomTextFieldProps(
                    key: _emailKey,
                    topic: "อีเมล",
                    controller: _emailController,
                    hintText: "กรุณาใส่อีเมลร้านค้า",
                    textInputAction: TextInputAction.next,
                    onChanged: (v) {
                      _emailKey.currentState!.validate();
                      setState(() {});
                    },
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
                      key: _passwordKey,
                      topic: "รหัสผ่าน",
                      controller: _passwordController,
                      hintText: "กรุณาใส่รหัสผ่านร้านค้า",
                      type: TextFieldType.password,
                      textInputAction: TextInputAction.done,
                      onChanged: (v) {
                        _passwordKey.currentState!.validate();
                        setState(() {});
                      },
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
                SizedBox(height: context.isPhone ? 10 : 30),
                CustomButton(
                  isLoading: authController.isLoadingLogin.value,
                  buttonName: "เข้าสู่ระบบ",
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    bool validate = _emailKey.currentState!.validate() &&
                        _passwordKey.currentState!.validate();

                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();

                    debugPrint("email: $email, password: $password");

                    setState(() {
                      if (validate == true) {
                        authController.login(email, password);
                      }

                      setState(() {});
                    });
                  },
                  icon: Icons.login_rounded,
                ),
              ],
            ),
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
    );
  }
}
