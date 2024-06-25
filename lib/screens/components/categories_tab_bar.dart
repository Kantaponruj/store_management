import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_management/constants/constant.dart';
import 'package:store_management/controllers/category_controller.dart';

import '../../shared/theme/color_theme.dart';
import '../../shared/theme/text_theme.dart';

class CategoriesTabBarComponent extends GetView<CategoryController> {
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
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "สินค้าทั้งหมด",
                    style: CustomTextTheme.subtitleBold,
                  ),
                ),
                Row(
                  children: titleActions ?? [],
                )
              ],
            ),
          ),
          Expanded(
            child: controller.obx(
              (state) => Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: state != null
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TabBar(
                          padding: const EdgeInsets.only(left: 20),
                          tabAlignment: TabAlignment.start,
                          isScrollable: true,
                          indicatorWeight: 1,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: const UnderlineTabIndicator(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          indicatorPadding: EdgeInsets.zero,
                          automaticIndicatorColorAdjustment: false,
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
                          labelStyle: CustomTextTheme.subtitleBold,
                          labelColor: ColorTheme.primary,
                          unselectedLabelColor: ColorTheme.black,
                          unselectedLabelStyle: CustomTextTheme.body,
                          dividerHeight: 0,
                          labelPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          tabs: categories
                              .map((e) => Tab(
                                    text: e,
                                    height: isPhone ? 30 : 40,
                                  ))
                              .toList(),
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
              onEmpty: const SizedBox.shrink(),
              onLoading: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
