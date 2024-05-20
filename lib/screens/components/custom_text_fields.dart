import 'package:flutter/material.dart';
import 'package:store_management/shared/theme/color_theme.dart';

import '../../shared/theme/text_theme.dart';

class CustomTextField extends StatelessWidget {
  final CustomTextFieldProps props;

  const CustomTextField({
    super.key,
    required this.props,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        props.topic != ""
            ? Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    props.isRequired
                        ? Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Text(
                              "*",
                              style: CustomTextTheme.bodyMedium.copyWith(
                                color: ColorTheme.error,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    Text(
                      "${props.topic}:",
                      style: CustomTextTheme.bodyMedium,
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
        TextFormField(
          key: props.key,
          controller: props.controller,
          style: CustomTextTheme.body,
          obscureText: props.type == TextFieldType.password,
          keyboardType: props.keyboardType,
          maxLines: props.maxLines,
          maxLength: props.maxLength,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            suffixIcon: props.suffixIcon,
            prefixIcon: props.prefixIcon,
            hintText: props.hintText,
            helperText: props.helperText,
            errorText: props.errorText,
          ),
          validator: props.validator,
          textInputAction: props.textInputAction,
          enabled: props.enabled,
          cursorColor: ColorTheme.primary,
          onChanged: props.onChanged,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      ],
    );
  }
}

enum TextFieldType { text, password }

class CustomTextFieldProps {
  final bool isRequired;
  final GlobalKey<FormFieldState<dynamic>>? key;
  final String topic;
  final TextFieldType type;
  final TextEditingController? controller;
  final int maxLines;
  final TextInputType? keyboardType;
  final int? maxLength;
  final double minWidth;
  final double? maxWidth;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final String? hintText;
  final String? helperText;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final String? errorText;
  final void Function(String)? onChanged;

  const CustomTextFieldProps({
    this.isRequired = false,
    this.key,
    required this.topic,
    this.type = TextFieldType.text,
    this.controller,
    this.maxLines = 1,
    this.keyboardType,
    this.maxLength,
    this.minWidth = 300,
    this.maxWidth,
    this.suffixIcon,
    this.prefixIcon,
    this.enabled = true,
    this.hintText,
    this.helperText,
    this.validator,
    this.textInputAction,
    this.errorText,
    this.onChanged,
  });
}

class CustomDropdownField extends StatelessWidget {
  final bool isRequired;
  final String topic;
  final void Function(dynamic)? onChanged;
  final List<CustomDropdownItem> items;
  final int? maxLength;
  final double minWidth;
  final double? maxWidth;
  final String? hintText;
  final String? Function(String?)? validator;

  const CustomDropdownField({
    super.key,
    this.isRequired = false,
    required this.topic,
    required this.items,
    this.maxLength,
    this.minWidth = 300,
    this.maxWidth,
    this.onChanged,
    this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topic != ""
            ? Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    isRequired
                        ? Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Text(
                              "*",
                              style: CustomTextTheme.bodyMedium.copyWith(
                                color: ColorTheme.error,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    Text(
                      topic,
                      style: CustomTextTheme.bodyMedium,
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
        DropdownButtonFormField(
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          dropdownColor: ColorTheme.white,
          onChanged: onChanged,
          hint: Text(
            hintText ?? "",
          ),
          items: items
              .map((e) => DropdownMenuItem(
                  value: e.value,
                  child: Text(
                    e.title,
                    style: CustomTextTheme.body,
                  )))
              .toList(),
          validator: validator,
        ),
      ],
    );
  }
}

class CustomDropdownItem {
  final String title;
  final String value;

  const CustomDropdownItem({required this.title, required this.value});
}

class CustomSuffixButton {
  final IconData icon;
  final VoidCallback onTap;

  const CustomSuffixButton({
    required this.icon,
    required this.onTap,
  });
}
