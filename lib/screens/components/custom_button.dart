import 'package:flutter/material.dart';
import 'package:store_management/constants/constant.dart';
import 'package:store_management/shared/theme/text_theme.dart';

import '../../shared/theme/color_theme.dart';

enum ButtonType { primary, secondary }

enum ButtonStatus { primary, secondary, disabled, error, success }

class CustomButton extends StatelessWidget {
  final String buttonName;
  final IconData? icon;
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final ButtonType type;
  final ButtonStatus status;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.buttonName,
    this.icon,
    required this.onPressed,
    this.width,
    this.height,
    this.margin,
    this.type = ButtonType.primary,
    this.status = ButtonStatus.primary,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor = ColorTheme.primary;

    switch (status) {
      case ButtonStatus.secondary:
        buttonColor = ColorTheme.secondary;
        break;
      case ButtonStatus.error:
        buttonColor = ColorTheme.error;
        break;
      case ButtonStatus.success:
        buttonColor = ColorTheme.success;
        break;
      default:
        buttonColor = ColorTheme.primary;
    }

    return Container(
      margin: margin,
      constraints: BoxConstraints(
        maxWidth: width ?? double.infinity,
        minHeight: height ?? 10,
      ),
      child: ElevatedButton(
        style: type == ButtonType.primary
            ? ElevatedButton.styleFrom(
                foregroundColor: ColorTheme.white,
                backgroundColor: onPressed != null || !isLoading
                    ? buttonColor
                    : ColorTheme.disabled,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              )
            : ElevatedButton.styleFrom(
                foregroundColor: buttonColor,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                side: BorderSide(width: 2, color: buttonColor),
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
        onPressed: isLoading ? null : onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: isPhone ? 10 : 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: isLoading
                ? [
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    )
                  ]
                : [
                    icon != null ? Icon(icon) : const SizedBox.shrink(),
                    Container(
                      padding: EdgeInsets.only(left: icon != null ? 10 : 0),
                      child: Text(
                        buttonName,
                        style: CustomTextTheme.subtitleBold,
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
