import 'package:flutter/material.dart';
import 'package:store_management/shared/theme/text_theme.dart';

import '../../shared/theme/color_theme.dart';

enum ButtonType { primary, secondary }

enum ButtonStatus { primary, disabled, error, success }

class CustomButton extends StatelessWidget {
  final String buttonName;
  final IconData? icon;
  final void Function()? onPressed;
  final double? width;
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
    this.margin,
    this.type = ButtonType.primary,
    this.status = ButtonStatus.primary,
    this.isLoading = false,
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
      constraints: BoxConstraints(
        maxWidth: width ?? double.infinity,
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
                backgroundColor: ColorTheme.white,
                surfaceTintColor: Colors.transparent,
                side: BorderSide(width: 2, color: buttonColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
        onPressed: isLoading ? null : onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon != null
                        ? Icon(icon, color: ColorTheme.white)
                        : const SizedBox.shrink(),
                    Container(
                      padding: EdgeInsets.only(left: icon != null ? 10 : 0),
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
