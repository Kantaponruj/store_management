import 'package:flutter/material.dart';

import '../../shared/components/color_theme.dart';
import '../../shared/components/text_theme.dart';

class CategoriesTabBarComponent extends StatelessWidget {
  final List<String> categories;
  final List<Widget> tabBarView;

  const CategoriesTabBarComponent({
    super.key,
    required this.categories,
    required this.tabBarView,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "สินค้าทั้งหมด",
              style: CustomTextTheme.subtitleBold,
            ),
          ),
          TabBar(
            padding: const EdgeInsets.only(left: 20),
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: ColorTheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            labelStyle: CustomTextTheme.bodyMedium,
            labelColor: ColorTheme.white,
            unselectedLabelColor: ColorTheme.primary,
            unselectedLabelStyle: CustomTextTheme.body,
            dividerHeight: 0,
            tabs: categories.map((e) => Tab(text: e)).toList(),
          ),
          Expanded(
            child: TabBarView(children: tabBarView),
          )
        ],
      ),
    );
  }
}
