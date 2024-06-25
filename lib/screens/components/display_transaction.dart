import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_management/models/components.dart';
import 'package:store_management/models/transaction.dart';
import 'package:store_management/screens/components/custom_button.dart';
import 'package:store_management/shared/theme/color_theme.dart';
import 'package:store_management/shared/theme/text_theme.dart';

class DisplayTransaction extends StatelessWidget {
  final String title;
  final String? subTitle;

  final RxList<TransactionProduct> transactionList;
  final bool paddingLeft;

  final String totalProduct;
  final String totalPrice;

  final List<CustomMenuItem>? popupMenu;
  final bool canDeleteProduct;
  final CustomButtonProps? customButtonProps;

  const DisplayTransaction({
    super.key,
    this.title = "สรุปบิล",
    this.subTitle,
    required this.transactionList,
    this.paddingLeft = true,
    required this.totalProduct,
    required this.totalPrice,
    this.popupMenu,
    this.canDeleteProduct = true,
    this.customButtonProps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: paddingLeft ? 20 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              margin: customButtonProps == null
                  ? null
                  : const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: popupMenu == null
                                ? Alignment.center
                                : Alignment.centerLeft,
                            child: Text(
                              "สรุปบิล",
                              style: CustomTextTheme.subtitleBold,
                            ),
                          ),
                        ),
                        popupMenu == null
                            ? const SizedBox()
                            : PopupMenuButton<CustomMenuItem>(
                                surfaceTintColor: ColorTheme.secondary,
                                offset: const Offset(0, 45),
                                icon: const Icon(Icons.more_vert),
                                itemBuilder: (BuildContext context) {
                                  if (popupMenu != null) {
                                    return popupMenu!
                                        .map(
                                          (e) => PopupMenuItem<CustomMenuItem>(
                                            onTap: e.onTap,
                                            child: Row(
                                              children: [
                                                Icon(e.icon),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  e.title,
                                                  style: CustomTextTheme.body,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList();
                                  } else {
                                    return [];
                                  }
                                },
                              ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: transactionList.length,
                      itemBuilder: (context, index) {
                        return buildListTileProduct(
                          id: transactionList[index].id,
                          amount: transactionList[index].amount,
                          name: transactionList[index].name,
                          price: transactionList[index].price,
                          totalPrice: transactionList[index].totalPrice,
                          onTap: canDeleteProduct
                              ? () {
                                  transactionList.removeAt(index);
                                }
                              : null,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: buildTotalText(
                      title: CustomText(
                        text: "รวมทั้งสิ้น  $totalProduct  ชิ้น",
                        style: CustomTextTheme.bodyMedium,
                      ),
                      content: CustomText(
                        text: totalPrice,
                        style: CustomTextTheme.titleBold.copyWith(
                          color: ColorTheme.success,
                        ),
                      ),
                      trailling: CustomText(
                        text: "บาท",
                        style: CustomTextTheme.body,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          customButtonProps != null
              ? CustomButton(
                  buttonName: customButtonProps?.text ?? "",
                  onPressed: customButtonProps!.onTap,
                  height: 60,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget buildListTileProduct({
    required String id,
    required int amount,
    required String name,
    required double price,
    required double totalPrice,
    void Function()? onTap,
  }) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(vertical: -3),
      leading: Text("${amount.toString()}x"),
      // onTap: onTap,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                name,
                style: CustomTextTheme.smallBody,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(left: 10),
            child: Visibility(
              visible: amount > 1,
              child: Container(
                alignment: Alignment.centerLeft,
                child: buildFittedText(
                  textObject: CustomText(
                    text: "$price/ชิ้น",
                    style: CustomTextTheme.description,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                buildFittedText(
                  textObject: CustomText(
                    text: totalPrice.toString(),
                    style: CustomTextTheme.smallBodyMedium,
                  ),
                ),
                const SizedBox(width: 5),
                buildFittedText(
                  textObject: CustomText(
                    text: "บาท",
                    style: CustomTextTheme.smallBody,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      trailing: onTap == null
          ? null
          : InkWell(
              onTap: onTap,
              child: const Icon(
                Icons.clear_outlined,
                color: ColorTheme.disabled,
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

  Widget showTextWithTitle({required String title, required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: CustomTextTheme.bodyMedium),
        Text(text, style: CustomTextTheme.body),
      ],
    );
  }
}
