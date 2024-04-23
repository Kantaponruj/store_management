import 'package:flutter/material.dart';

import '../theme/color_theme.dart';

class BottomNavBarComponent extends StatelessWidget {
  final List listPage;
  final int currentIndex;
  final void Function(int) onTap;

  const BottomNavBarComponent({
    super.key,
    required this.listPage,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: ColorTheme.primary,
        items: listPage
            .map((item) => BottomNavigationBarItem(
                  icon: Icon(
                    item['icon'],
                  ),
                  label: item['menuName'] ?? item['title'],
                ))
            .toList());
  }
}
