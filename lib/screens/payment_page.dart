import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promptpay_qrcode_generate/promptpay_qrcode_generate.dart';
import 'package:store_management/controllers/transaction_controller.dart';
import 'package:store_management/models/components.dart';
import 'package:store_management/models/transaction.dart';
import 'package:store_management/screens/components/display_transaction.dart';
import 'package:store_management/screens/components/snack_bar.dart';
import 'package:store_management/screens/main_page.dart';
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

  final String storeId = "1234567890";
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
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                  child: Center(
                    child: QRCodeGenerate(
                      isShowAmountDetail: false,
                      promptPayId: promptPayId,
                      amount: transactionController.tranTotalPrice,
                      height: double.infinity,
                      promptPayDetailCustom: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 20),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              displayTransactionSide(
                transactionList: transactionController.transactionProducts,
                paddingLeft: true,
              ),
            ],
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

  Widget displayTransactionSide({
    required RxList<TransactionProduct> transactionList,
    bool paddingLeft = true,
  }) {
    return Expanded(
      flex: 3,
      child: DisplayTransaction(
        transactionList: transactionList,
        paddingLeft: paddingLeft,
        totalProduct: transactionController.tranTotalCount.toString(),
        totalPrice: transactionController.tranTotalPrice == 0
            ? "0"
            : transactionController.tranTotalPrice.toStringAsFixed(2),
        canDeleteProduct: false,
        customButtonProps: CustomButtonProps(
          text: "เสร็จสิ้น",
          onTap: () {
            transactionController.clearTransaction();
            Get.offAll(() => const MainPage());
            displaySnackbar(
              status: CustomSnackbarStatus.success,
              title: 'สถาะการชำระเงิน',
              content: 'ชำระเงินด้วย PromptPay สำเร็จ',
            );
          },
        ),
      ),
    );
  }
}
