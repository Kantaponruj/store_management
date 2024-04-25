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
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            props.topic,
            style: CustomTextTheme.bodyMedium,
          ),
        ),
        TextFormField(
          controller: props.controller,
          style: CustomTextTheme.body,
          keyboardType: props.keyboardType,
          maxLines: props.maxLines,
          maxLength: props.maxLength,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            suffix: props.suffix,
            prefix: props.prefix,
          ),
          enabled: props.enabled,
          cursorColor: ColorTheme.primary,
          onChanged: (value) {},
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      ],
    );
  }
}

class CustomTextFieldProps {
  final String topic;
  final TextEditingController? controller;
  final int maxLines;
  final TextInputType? keyboardType;
  final int? maxLength;
  final double minWidth;
  final double? maxWidth;
  final Widget? prefix;
  final Widget? suffix;
  final bool enabled;

  const CustomTextFieldProps({
    required this.topic,
    this.controller,
    this.maxLines = 1,
    this.keyboardType,
    this.maxLength,
    this.minWidth = 300,
    this.maxWidth,
    this.suffix,
    this.prefix,
    this.enabled = true,
  });
}

class CustomDropdownField extends StatelessWidget {
  final String topic;
  final void Function(dynamic)? onChanged;
  final List<CustomDropdownItem> items;
  final int? maxLength;
  final double minWidth;
  final double? maxWidth;

  const CustomDropdownField({
    super.key,
    required this.topic,
    required this.items,
    this.maxLength,
    this.minWidth = 300,
    this.maxWidth,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            topic,
            style: CustomTextTheme.bodyMedium,
          ),
        ),
        DropdownButtonFormField(
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          dropdownColor: ColorTheme.white,
          onChanged: onChanged,
          items: items
              .map((e) => DropdownMenuItem(
                  value: e.value,
                  child: Text(
                    e.title,
                    style: CustomTextTheme.body,
                  )))
              .toList(),
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
