import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_management/shared/theme/color_theme.dart';
import 'package:store_management/shared/theme/text_theme.dart';

enum CustomSnackbarStatus { success, error, info }

Color getSnackbarColor(CustomSnackbarStatus status, {double opacity = 0.2}) {
  double thisOpacity = opacity > 1 ? 1 : opacity;

  switch (status) {
    case CustomSnackbarStatus.success:
      return ColorTheme.success.withOpacity(thisOpacity);
    case CustomSnackbarStatus.error:
      return ColorTheme.error.withOpacity(thisOpacity);
    case CustomSnackbarStatus.info:
      return ColorTheme.disabled.withOpacity(0.5);
  }
}

Color getTextColor(CustomSnackbarStatus status) {
  switch (status) {
    case CustomSnackbarStatus.success:
      return ColorTheme.black;
    case CustomSnackbarStatus.error:
      return ColorTheme.white;
    case CustomSnackbarStatus.info:
      return ColorTheme.primary;
  }
}

SnackbarController displaySnackbar({
  required String title,
  required String content,
  CustomSnackbarStatus status = CustomSnackbarStatus.info,
}) {
  return Get.snackbar(
    title,
    content,
    margin: const EdgeInsets.all(20),
    titleText: Text(
      title,
      style: CustomTextTheme.titleMedium.copyWith(
        color: getTextColor(status),
      ),
    ),
    barBlur: 10,
    messageText: Text(
      content,
      style: CustomTextTheme.subtitle.copyWith(
        color: getTextColor(status),
      ),
    ),
    padding: const EdgeInsets.all(20),
    backgroundColor: getSnackbarColor(status),
    boxShadows: [
      BoxShadow(
        color: ColorTheme.black.withOpacity(0.1),
        spreadRadius: 0.5,
        blurRadius: 5,
        offset: const Offset(0, 3),
      )
    ],
  );
}
