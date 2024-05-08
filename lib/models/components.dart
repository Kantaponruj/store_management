import 'package:flutter/material.dart';

class CustomMenuItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  CustomMenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

class CustomButtonProps {
  final String text;
  final void Function()? onTap;

  CustomButtonProps({
    required this.text,
    required this.onTap,
  });
}
