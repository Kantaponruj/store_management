import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    DateTime now = DateTime.now();
    DateFormat formatter =
        DateFormat('สวัสดี.......วันที่ dd เดือน MMM ปี yyyy');
    String dateNow = formatter.format(now);

    final List listPage = [
      {
        "icon": Icons.store,
        "menuName": "POS",
        "title": dateNow,
        "page": const POSPage(),
      },
      {
        "icon": Icons.book,
        "title": "Manual POS",
        "page": const ManualPOSPage(),
      },
      {
        "icon": Icons.more_horiz,
        "title": "More",
        "page": const HomePage(),
      },
    ];

    return Scaffold(
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
