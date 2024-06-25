import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store_management/screens/home_page.dart';
import 'package:store_management/screens/manual_pos_page.dart';
import 'package:store_management/screens/pos_page.dart';
import 'package:store_management/shared/components/bottom_nav_bar_component.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final context = Get.context!;
    final settings = GetStorage("Settings");

    settings.write('isPhone', context.isPhone);

    final List listPage = [
      {
        "icon": Icons.storefront_rounded,
        "title": "POS",
        "page": const POSPage(),
      },
      {
        "icon": Icons.inventory_rounded,
        "title": "คลังสินค้า",
        "page": const ManualPOSPage(),
      },
      {
        "icon": Icons.more_horiz,
        "title": "อื่น ๆ",
        "page": const HomePage(),
      },
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: listPage[selectedIndex]['page'],
      ),
      bottomNavigationBar: BottomNavBarComponent(
          listPage: listPage,
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          }),
    );
  }
}
