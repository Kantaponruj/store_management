import 'package:flutter/material.dart';

import '../../shared/theme/color_theme.dart';
import '../../shared/theme/text_theme.dart';

class CategoriesTabBarComponent extends StatelessWidget {
  final List<String> categories;
  final List<Widget> tabBarView;
  final List<Widget>? titleActions;
  final List<Widget>? tabActions;

  const CategoriesTabBarComponent({
    super.key,
    required this.categories,
    required this.tabBarView,
    this.titleActions,
    this.tabActions,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "สินค้าทั้งหมด",
                    style: CustomTextTheme.subtitleBold,
                  ),
                ),
              ),
              Row(
                children: titleActions ?? [],
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TabBar(
                  padding: const EdgeInsets.only(left: 20),
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide.none,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  automaticIndicatorColorAdjustment: false,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  labelStyle: CustomTextTheme.subtitleBold,
                  labelColor: ColorTheme.primary,
                  unselectedLabelColor: ColorTheme.black,
                  unselectedLabelStyle: CustomTextTheme.body,
                  dividerHeight: 0,
                  tabs: categories.map((e) => Tab(text: e)).toList(),
                ),
              ),
              Row(
                children: tabActions ?? [],
              )
            ],
          ),
          Expanded(
            child: TabBarView(children: tabBarView),
          )
        ],
      ),
    );
  }
}
