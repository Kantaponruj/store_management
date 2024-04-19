import 'package:flutter/material.dart';

import '../../models/button_values.dart';

class CalculatorComponent extends StatefulWidget {
  const CalculatorComponent({super.key});

  @override
  State<CalculatorComponent> createState() => _CalculatorComponentState();
}

class _CalculatorComponentState extends State<CalculatorComponent> {
  String number1 = ""; // . 0-9
  String operand = ""; // + - * /
  String number2 = ""; // . 0-9

  String total = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      color: const Color(0xffF2F2F2),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    // output
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              total,
                              style: const TextStyle(),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SingleChildScrollView(
                              reverse: true,
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                "$number1$operand$number2".isEmpty
                                    ? "0"
                                    : "$number1$operand$number2",
                                style: const TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: Btn.buttonValue
                                        .map(
                                          (value) => displayButton(value),
                                        )
                                        .toList(),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: Btn.buttonNumbers
                                        .take(3)
                                        .map(
                                          (value) => displayButton(value),
                                        )
                                        .toList(),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: Btn.buttonNumbers
                                        .skip(3)
                                        .take(3)
                                        .map(
                                          (value) => displayButton(value),
                                        )
                                        .toList(),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: Btn.buttonNumbers
                                        .skip(6)
                                        .take(3)
                                        .map(
                                          (value) => displayButton(value),
                                        )
                                        .toList(),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: Btn.buttonNumbers
                                        .skip(9)
                                        .map(
                                          (value) => displayButton(value),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: Btn.buttonOperators
                                  .map(
                                    (value) => displayButton(value),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton({
    Icon? icon,
    String? text,
    required String value,
    bool textBold = true,
  }) {
    return Expanded(
      flex: value == Btn.n0 ? 2 : 1,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        )),
        child: InkWell(
          onTap: () => onBtnTap(value),
          child: Center(
            child: icon ??
                Text(
                  text ?? value,
                  style: TextStyle(
                    fontWeight: textBold ? FontWeight.bold : FontWeight.normal,
                    fontSize: 24,
                  ),
                ),
          ),
        ),
      ),
    );
  }

  Widget displayButton(value) {
    switch (value) {
      case Btn.clr:
        return buildButton(
            value: value,
            icon: const Icon(
              Icons.delete_rounded,
              color: Colors.red,
              size: 30,
            ));
      case Btn.del:
        return buildButton(
            value: value,
            icon: const Icon(
              Icons.backspace_rounded,
              color: Colors.red,
              size: 30,
            ));
      case Btn.per || Btn.multiply || Btn.add || Btn.subtract || Btn.divide:
        return buildButton(
          value: value,
          text: value,
          textBold: false,
        );
      default:
        return buildButton(value: value, text: value);
    }
  }

  // ########
  void onBtnTap(String value) {
    if (value == Btn.del) {
      delete();
      return;
    }

    if (value == Btn.clr) {
      clearAll();
      return;
    }

    if (value == Btn.per) {
      convertToPercentage();
      return;
    }

    if (value == Btn.calculate) {
      calculate();
      return;
    }

    appendValue(value);
  }

  // ##############
  // calculates the result
  void calculate() {
    if (number1.isEmpty) return;
    if (operand.isEmpty) return;
    if (number2.isEmpty) return;

    final double num1 = double.parse(number1);
    final double num2 = double.parse(number2);

    var result = 0.0;
    switch (operand) {
      case Btn.add:
        result = num1 + num2;
        break;
      case Btn.subtract:
        result = num1 - num2;
        break;
      case Btn.multiply:
        result = num1 * num2;
        break;
      case Btn.divide:
        result = num1 / num2;
        break;
      default:
    }

    setState(() {
      if (total == "") {
        total = number1 + operand + number2;
      } else {
        total = total + operand + number2;
      }

      number1 = result.toStringAsPrecision(3);

      if (number1.endsWith(".0")) {
        number1 = number1.substring(0, number1.length - 2);
      }

      operand = "";
      number2 = "";
    });
  }

  // ##############
  // converts output to %
  void convertToPercentage() {
    // ex: 434+324
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      // calculate before conversion
      calculate();
    }

    if (operand.isNotEmpty) {
      // cannot be converted
      return;
    }

    final number = double.parse(number1);
    setState(() {
      number1 = "${(number / 100)}";
      operand = "";
      number2 = "";
    });
  }

  // ##############
  // clears all output
  void clearAll() {
    setState(() {
      number1 = "";
      operand = "";
      number2 = "";

      total = "";
    });
  }

  // ##############
  // delete one from the end
  void delete() {
    if (number2.isNotEmpty) {
      // 12323 => 1232
      number2 = number2.substring(0, number2.length - 1);
    } else if (operand.isNotEmpty) {
      operand = "";
    } else if (number1.isNotEmpty) {
      number1 = number1.substring(0, number1.length - 1);
    }

    setState(() {});
  }

  // #############
  // appends value to the end
  void appendValue(String value) {
    // number1 opernad number2
    // 234       +      5343

    // if is operand and not "."
    if (value != Btn.dot && int.tryParse(value) == null) {
      // operand pressed
      if (operand.isNotEmpty && number2.isNotEmpty) {
        // TODO calculate the equation before assigning new operand
        calculate();
      }
      operand = value;
    }
    // assign value to number1 variable
    else if (number1.isEmpty || operand.isEmpty) {
      // check if value is "." | ex: number1 = "1.2"
      if (value == Btn.dot && number1.contains(Btn.dot)) return;
      if (value == Btn.dot && (number1.isEmpty || number1 == Btn.n0)) {
        // ex: number1 = "" | "0"
        value = "0.";
      }
      number1 += value;
    }
    // assign value to number2 variable
    else if (number2.isEmpty || operand.isNotEmpty) {
      // check if value is "." | ex: number1 = "1.2"
      if (value == Btn.dot && number2.contains(Btn.dot)) return;
      if (value == Btn.dot && (number2.isEmpty || number2 == Btn.n0)) {
        // number1 = "" | "0"
        value = "0.";
      }
      number2 += value;
    }

    setState(() {});
  }
}
