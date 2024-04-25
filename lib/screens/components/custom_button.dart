import 'package:flutter/material.dart';
import 'package:store_management/shared/theme/text_theme.dart';

import '../../shared/theme/color_theme.dart';

enum ButtonType { primary, secondary }

enum ButtonStatus { primary, error, success }

class CustomButton extends StatelessWidget {
  final String buttonName;
  final IconData? icon;
  final void Function()? onPressed;
  final double? width;
  final EdgeInsets? margin;
  final ButtonType type;
  final ButtonStatus status;

  const CustomButton({
    super.key,
    required this.buttonName,
    this.icon,
    required this.onPressed,
    this.width,
    this.margin,
    this.type = ButtonType.primary,
    this.status = ButtonStatus.primary,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor = ColorTheme.primary;

    switch (status) {
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
      child: ElevatedButton(
        style: type == ButtonType.primary
            ? ElevatedButton.styleFrom(
                foregroundColor: ColorTheme.white,
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              )
            : ElevatedButton.styleFrom(
                foregroundColor: buttonColor,
                backgroundColor: ColorTheme.white,
                surfaceTintColor: Colors.transparent,
                side: BorderSide(width: 2, color: buttonColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
        onPressed: onPressed,
        child: Container(
          width: width,
          padding: EdgeInsets.symmetric(vertical: icon != null ? 10 : 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null
                  ? Icon(icon, color: ColorTheme.white)
                  : const SizedBox.shrink(),
              Container(
                padding: EdgeInsets.only(left: icon != null ? 5 : 0),
                child: Text(
                  buttonName,
                  style: CustomTextTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
