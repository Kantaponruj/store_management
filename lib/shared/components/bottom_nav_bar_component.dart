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
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Container(
        color: ColorTheme.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            type: BottomNavigationBarType.shifting,
            selectedItemColor: ColorTheme.primary,
            unselectedItemColor: ColorTheme.disabled,
            elevation: 0,
            items: listPage
                .map((item) => BottomNavigationBarItem(
                      backgroundColor: ColorTheme.white,
                      icon: Icon(
                        item['icon'],
                      ),
                      label: item['menuName'] ?? item['title'],
                    ))
                .toList()),
      ),
    );
  }
}
