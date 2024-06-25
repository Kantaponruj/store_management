import 'package:flutter/material.dart';
import 'package:store_management/constants/constant.dart';
import 'package:store_management/shared/theme/color_theme.dart';
import 'package:store_management/shared/theme/text_theme.dart';

class SelectPayment extends StatelessWidget {
  final List<Widget> paymentList;

  const SelectPayment({
    super.key,
    required this.paymentList,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(50),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("ชําระเงิน", style: CustomTextTheme.titleBold),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 40),
            child: Text(
              "เลือกช่องทางการชําระเงิน",
              style: CustomTextTheme.body,
            ),
          ),
          isPhone
              ? Column(
                  children: paymentList,
                )
              : Row(
                  children: paymentList,
                ),
        ],
      ),
    );
  }
}

Widget paymentCard({
  required String text,
  required IconData icon,
  required VoidCallback onPressed,
  Color? color,
}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color ?? ColorTheme.white,
        boxShadow: [
          BoxShadow(
            color: ColorTheme.black.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: ColorTheme.primary,
              size: 30,
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Text(text, style: CustomTextTheme.subtitleBold),
            ),
          ],
        ),
      ),
    ),
  );
}
