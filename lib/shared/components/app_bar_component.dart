import 'package:flutter/material.dart';
import 'package:store_management/shared/theme/color_theme.dart';
import 'package:store_management/shared/theme/text_theme.dart';

class CustomAppBarComponent extends StatefulWidget
    implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomAppBarComponent({key, required this.title, this.actions})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(
          key: key,
        );

  @override
  final Size preferredSize; // default is 56.0

  @override
  State<CustomAppBarComponent> createState() => _CustomAppBarComponentState();
}

class _CustomAppBarComponentState extends State<CustomAppBarComponent> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorTheme.primary,
      foregroundColor: ColorTheme.white,
      title: Text(
        widget.title,
        style: CustomTextTheme.titleBold,
      ),
      actions: widget.actions,
    );
  }
}
