import 'package:flutter/material.dart';

class Btn {
  static const String del = "AC";
  static const String clr = "C";
  static const String per = "%";
  static const String multiply = "×";
  static const String divide = "÷";
  static const String add = "+";
  static const String subtract = "-";
  static const String calculate = "=";
  static const String dot = ".";

  static const String n0 = "0";
  static const String n1 = "1";
  static const String n2 = "2";
  static const String n3 = "3";
  static const String n4 = "4";
  static const String n5 = "5";
  static const String n6 = "6";
  static const String n7 = "7";
  static const String n8 = "8";
  static const String n9 = "9";

  static const List<String> buttonValues = [
    del,
    clr,
    per,
    multiply,
    n7,
    n8,
    n9,
    divide,
    n4,
    n5,
    n6,
    subtract,
    n1,
    n2,
    n3,
    add,
    n0,
    dot,
    calculate,
  ];

  static const List<String> buttonValue = [
    clr,
    del,
    per,
  ];

  static const List<String> buttonNumbers = [
    n7,
    n8,
    n9,
    n4,
    n5,
    n6,
    n1,
    n2,
    n3,
    n0,
    dot,
  ];

  static const List<String> buttonOperators = [
    divide,
    multiply,
    subtract,
    add,
    calculate,
  ];

  static const List<String> buttonPOSOperators = [
    del,
    calculate,
  ];
}

class ButtonProps {
  String name;
  IconData? icon;
  void Function()? onPressed;

  ButtonProps({
    required this.name,
    this.icon,
    this.onPressed,
  });
}

class IconButtonProps {
  String? name;
  IconData icon;
  void Function()? onPressed;

  IconButtonProps({
    this.name,
    required this.icon,
    this.onPressed,
  });
}
