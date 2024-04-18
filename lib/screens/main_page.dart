import 'package:flutter/material.dart';
import 'package:store_management/screens/home_page.dart';
import 'package:store_management/screens/manual_pos_page.dart';
import 'package:store_management/screens/pos_page.dart';
import 'package:store_management/shared/components/app_bar_component.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1;

  final List listPage = [
    {
      "icon": Icons.home,
      "title": "Home Page",
      "page": const HomePage(),
    },
    {
      "icon": Icons.store,
      "title": "POS",
      "page": const POSPage(),
    },
    {
      "icon": Icons.book,
      "title": "Manual POS",
      "page": const ManualPOSPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarComponent(title: listPage[_selectedIndex]['title']),
      drawer: Drawer(
        child: SizedBox(
          height: double.maxFinite,
          child: ListView.builder(
            itemCount: listPage.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(listPage[index]['icon']),
                title: Text(listPage[index]['title']),
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                    Navigator.pop(context);
                  });
                },
              );
            },
          ),
        ),
      ),
      body: SafeArea(
        child: listPage[_selectedIndex]['page'],
      ),
    );
  }
}
