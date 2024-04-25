import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../models/product.dart';
import '../../shared/theme/color_theme.dart';
import '../../shared/theme/text_theme.dart';

class DisplayProductDetail extends StatelessWidget {
  final ProductModel product;

  const DisplayProductDetail({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Text(
              "รายละเอียดสินค้า",
              style: CustomTextTheme.titleBold,
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  height: 200,
                  child: Container(
                    color: ColorTheme.disabled,
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 20,
                  right: 20,
                  child: Column(
                    children: [
                      Card(
                        surfaceTintColor: Colors.transparent,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              displayTag(
                                text: product.category,
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Text(
                                    "รหัสสินค้า: ${product.id.toString()}"),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  product.name,
                                  style: CustomTextTheme.subtitleBold.copyWith(
                                    color: ColorTheme.primary,
                                  ),
                                ),
                              ),
                              product.description != null &&
                                      product.description!.isNotEmpty
                                  ? Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: Text(product.description ?? ""),
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: SizedBox.shrink(),
                                    ),
                              showPrice(text: product.price.toString()),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        surfaceTintColor: Colors.transparent,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ข้อมูลคลังสินค้า",
                                style: CustomTextTheme.bodyBold,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    showTextWithTitle(
                                        title: "จํานวนสินค้า",
                                        text: "${product.quantity} ชิ้น"),
                                  ],
                                ),
                              ),
                              showTextWithTitle(
                                  title: "ราคาทุน / ชิ้น",
                                  text: "${product.price} บาท"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget displayTag({required String text, Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: color ?? ColorTheme.secondary,
      ),
      child: Text(text.capitalize ?? "",
          style: CustomTextTheme.description.copyWith(
            color: ColorTheme.white,
          )),
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

  Widget showPrice({required String text}) {
    return Row(
      children: [
        Text("฿ ", style: CustomTextTheme.body),
        Text(text,
            style: CustomTextTheme.subtitleBold.copyWith(
              color: ColorTheme.black,
            )),
        Text(" บาท", style: CustomTextTheme.body),
      ],
    );
  }
}
