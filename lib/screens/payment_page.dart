import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promptpay_qrcode_generate/promptpay_qrcode_generate.dart';
import 'package:store_management/constants/constant.dart';
import 'package:store_management/controllers/transaction_controller.dart';
import 'package:store_management/models/components.dart';
import 'package:store_management/models/transaction.dart';
import 'package:store_management/screens/components/custom_button.dart';
import 'package:store_management/screens/components/display_transaction.dart';
import 'package:store_management/screens/components/snack_bar.dart';
import 'package:store_management/screens/main_page.dart';
import 'package:store_management/shared/theme/color_theme.dart';
import 'package:store_management/shared/theme/text_theme.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final transactionController = Get.put(TransactionController());

  final String promptPayId = "0939529954";
  final String promptPayName = "Miss Mile RMS";

  final String storeName = "Mile Retail Store";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("การชำระเงิน"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: isPhone
              ? Column(
                  children: [
                    SizedBox(
                      height: 600,
                      child: qrGenerator(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    displayButton(),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: qrGenerator(),
                    ),
                    Expanded(
                      flex: 3,
                      child: displayTransactionSide(
                        transactionList:
                            transactionController.transactionProducts,
                        paddingLeft: true,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget qrGenerator() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(
          vertical: isPhone ? 20 : 50, horizontal: isPhone ? 20 : 50),
      child: Center(
        child: QRCodeGenerate(
          isShowAmountDetail: false,
          promptPayId: promptPayId,
          amount: transactionController.tranTotalPrice,
          height: double.infinity,
          promptPayDetailCustom: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: isPhone ? 20 : 50),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: isPhone ? 10 : 20),
                  child: Text(
                    storeName,
                    style: CustomTextTheme.titleBold,
                  ),
                ),
                displayText(
                  title: "ชื่อบัญชี:",
                  content: promptPayName,
                  isTitle: true,
                ),
                displayText(
                  title: "เลขบัญชี:",
                  content: promptPayId.replaceAllMapped(
                      RegExp(r'(\d{3})(\d{3})(\d+)'),
                      (Match m) => "${m[1]}-${m[2]}-${m[3]}"),
                  isTitle: false,
                  marginTop: 10,
                ),
                isPhone ? displayTotal() : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget displayText({
    required String title,
    required String content,
    required bool isTitle,
    double? marginTop,
  }) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: marginTop ?? 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: isTitle
                ? CustomTextTheme.titleBold
                : CustomTextTheme.subtitleBold,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              content,
              style: isTitle ? CustomTextTheme.title : CustomTextTheme.subtitle,
            ),
          ),
        ],
      ),
    );
  }

  void onTapFinishButton() {
    transactionController.clearTransaction();
    Get.offAll(() => const MainPage());
    displaySnackbar(
      status: CustomSnackbarStatus.success,
      title: 'สถาะการชำระเงิน',
      content: 'ชำระเงินด้วย PromptPay สำเร็จ',
    );
  }

  Widget displayTransactionSide({
    required RxList<TransactionProduct> transactionList,
    bool paddingLeft = true,
  }) {
    return DisplayTransaction(
      transactionList: transactionList,
      paddingLeft: paddingLeft,
      totalProduct: transactionController.tranTotalCount.toString(),
      totalPrice: transactionController.tranTotalPrice == 0
          ? "0"
          : transactionController.tranTotalPrice.toStringAsFixed(2),
      canDeleteProduct: false,
      customButtonProps: CustomButtonProps(
        text: "เสร็จสิ้น",
        onTap: onTapFinishButton,
      ),
    );
  }

  Widget displayButton() {
    return CustomButton(
      height: 60,
      buttonName: "เสร็จสิ้น",
      onPressed: onTapFinishButton,
    );
  }

  Widget displayTotal() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: buildTotalText(
        title: CustomText(
          text:
              "รวมทั้งสิ้น  ${transactionController.tranTotalCount.toString()} ชิ้น",
          style: CustomTextTheme.bodyMedium,
        ),
        content: CustomText(
          text: transactionController.tranTotalPrice == 0
              ? "0"
              : transactionController.tranTotalPrice.toStringAsFixed(2),
          style: CustomTextTheme.titleBold.copyWith(
            color: ColorTheme.success,
          ),
        ),
        trailling: CustomText(
          text: "บาท",
          style: CustomTextTheme.body,
        ),
      ),
    );
  }

  Widget buildTotalText({
    required CustomText title,
    required CustomText content,
    required CustomText trailling,
  }) {
    return Row(
      children: [
        Text(
          title.text,
          style: title.style,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  content.text,
                  style: content.style,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.centerRight,
                child: Text(
                  trailling.text,
                  style: trailling.style,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
