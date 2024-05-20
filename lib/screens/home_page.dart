// Flutter imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_management/controllers/auth_controller.dart';
import 'package:store_management/models/components.dart';
import 'package:store_management/shared/theme/color_theme.dart';

import '../shared/theme/text_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authController = Get.put(AuthController());

  late final firebaseUser = authController.firebaseUser.value;
  late final userEmail = firebaseUser!.email ?? "Guest";
  late final String userName = firebaseUser != null &&
          firebaseUser!.displayName != "" &&
          firebaseUser!.displayName != null
      ? firebaseUser!.displayName!
      : userEmail;

  @override
  Widget build(BuildContext context) {
    List<CustomMenuItem> menuItems = [
      CustomMenuItem(
        icon: Icons.inventory_rounded,
        title: "สินค้าทั้งหมด",
        onTap: () {
          Get.toNamed("/product");
        },
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        profileSection(),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Menu",
                  style: CustomTextTheme.titleBold,
                ),
              ),
              Wrap(
                spacing: 20,
                children: menuItems
                    .map((e) => menuCard(
                          title: e.title,
                          icon: e.icon,
                          onTap: e.onTap,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget profileSection() {
    return context.isPhone
        ? Container(
            color: ColorTheme.primary,
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ListTile(
              title: Text("สวัสดี, ", style: CustomTextTheme.titleBold),
              subtitle: Text(userName, style: CustomTextTheme.subtitle),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    color: ColorTheme.black,
                    onPressed: () {
                      Get.toNamed('/profile');
                    },
                    icon: const Icon(Icons.settings_rounded, size: 30),
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout_rounded, size: 30),
                    color: ColorTheme.white,
                    onPressed: () {
                      Get.offAllNamed('/login');
                      authController.signOut();
                    },
                  ),
                ],
              ),
            ),
          )
        : Container(
            color: ColorTheme.primary,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: ListTile(
              title: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: ColorTheme.background,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: const CircleAvatar(
                            maxRadius: 40,
                            backgroundColor: ColorTheme.primary,
                            foregroundColor: ColorTheme.white,
                            child: Icon(Icons.person_rounded),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("สวัสดี, ", style: CustomTextTheme.titleBold),
                            Text(
                              userName,
                              style: CustomTextTheme.body,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.all(10),
                      child: IconButton(
                        color: ColorTheme.black,
                        onPressed: () {
                          Get.toNamed('/profile');
                        },
                        icon: const Icon(Icons.settings_rounded, size: 30),
                      ),
                    ),
                  ],
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.logout_rounded, size: 30),
                color: ColorTheme.white,
                onPressed: () {
                  Get.offAllNamed('/login');
                  authController.signOut();
                },
              ),
            ),
          );
  }

  Widget menuCard(
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: ColorTheme.primary,
        child: SizedBox(
          height: 150,
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: ColorTheme.white,
                size: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Text(
                  title,
                  style: CustomTextTheme.bodyBold.copyWith(
                    color: ColorTheme.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
