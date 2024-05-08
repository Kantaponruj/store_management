import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_management/utils/mapping_status.dart';

import '../../controllers/category_controller.dart';
import '../../controllers/product_controller.dart';
import '../../models/product.dart';
import '../../shared/theme/color_theme.dart';
import '../../shared/theme/text_theme.dart';
import 'custom_button.dart';
import 'custom_text_fields.dart';

class ModalCreateProduct extends StatefulWidget {
  const ModalCreateProduct({super.key});

  @override
  State<ModalCreateProduct> createState() => _ModalCreateProductState();
}

class _ModalCreateProductState extends State<ModalCreateProduct> {
  final productController = Get.put(ProductController());
  final categoryController = Get.put(CategoryController());

  String type = "";
  XFile? image;

  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final navigator = Navigator.of(context);

    return Obx(() {
      final categoryList = categoryController.categoryList;

      return AlertDialog(
        backgroundColor: ColorTheme.white,
        surfaceTintColor: ColorTheme.white,
        content: Stack(
          children: [
            closeModalButton(),
            Container(
              width: size.width * 0.5,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: productController.isReview.value
                  ? ConfirmCreate(
                      product: productController.product.value,
                      onPrevios: () {
                        productController.isReview.value = false;
                      },
                      onSubmit: () async {
                        productController
                            .addProduct(productController.product.value);

                        productController.isReview.value = false;
                        navigator.pop();
                      },
                    )
                  : Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text("เพิ่มสินค้า",
                                style: CustomTextTheme.titleBold),
                          ),
                          Expanded(
                            child: Container(
                              constraints: BoxConstraints(
                                maxHeight: size.height * 0.5,
                                maxWidth: 400,
                              ),
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("รูปภาพสินค้า",
                                          style: CustomTextTheme.bodyMedium),
                                      Container(
                                        constraints: const BoxConstraints(
                                          maxHeight: 150,
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: ColorTheme.background
                                                .withOpacity(0.2),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: ColorTheme.background,
                                        ),
                                        alignment: Alignment.center,
                                        child: InkWell(
                                          onTap: () async {
                                            debugPrint("Tap");
                                            final ImagePicker picker =
                                                ImagePicker();

                                            image = await picker.pickImage(
                                              source: ImageSource.gallery,
                                            );
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.add_a_photo_outlined,
                                                color: ColorTheme.primary,
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                  "เพิ่มรูปภาพ",
                                                  style: CustomTextTheme.body
                                                      .copyWith(
                                                    color: ColorTheme.primary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      CustomDropdownField(
                                        topic: "ประเภทสินค้า",
                                        items: categoryList
                                            .where((element) =>
                                                element.key != "all")
                                            .map((e) => CustomDropdownItem(
                                                  value: e.key,
                                                  title: e.name,
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            type = value;
                                          });
                                        },
                                      ),
                                      CustomTextField(
                                        props: CustomTextFieldProps(
                                          controller: idController,
                                          topic: "รหัสสินค้า",
                                          keyboardType: TextInputType.number,
                                        ),

                                        // iconButton: IconButtonProps(
                                        //   icon: Icons.qr_code_scanner_outlined,
                                        //   onPressed: () {
                                        //     debugPrint("onPressed");
                                        //   },
                                        // ),
                                      ),
                                      CustomTextField(
                                        props: CustomTextFieldProps(
                                          controller: nameController,
                                          topic: "ชื่อสินค้า",
                                        ),
                                      ),
                                      CustomTextField(
                                        props: CustomTextFieldProps(
                                          controller: descriptionController,
                                          topic: "คำอธิบาย",
                                          maxLines: 3,
                                        ),
                                      ),
                                      CustomTextField(
                                        props: CustomTextFieldProps(
                                          controller: quantityController,
                                          topic: "จํานวน",
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                      CustomTextField(
                                        props: CustomTextFieldProps(
                                          controller: priceController,
                                          topic: "ราคา",
                                          maxWidth: 50,
                                          keyboardType: TextInputType.number,
                                          prefix: const Icon(
                                            Icons.attach_money_outlined,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: CustomButton(
                                            buttonName: "ยกเลิก",
                                            margin: const EdgeInsets.only(
                                                right: 20),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            type: ButtonType.secondary,
                                            status: ButtonStatus.error,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: CustomButton(
                                            buttonName: "ถัดไป",
                                            onPressed: () {
                                              /// TODO: add validation
                                              final itemProduct = ProductModel(
                                                id: idController.text,
                                                name: nameController.text,
                                                description:
                                                    descriptionController.text,
                                                category: type,
                                                price: double.parse(
                                                    priceController.text),
                                                quantity: int.parse(
                                                    quantityController.text),
                                              );

                                              productController.product.value =
                                                  itemProduct;
                                              productController.isReview.value =
                                                  true;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      );
    });
  }

  Widget closeModalButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.topRight,
        child: const Icon(
          Icons.close_outlined,
          color: ColorTheme.disabled,
        ),
      ),
    );
  }
}

class ConfirmCreate extends StatelessWidget {
  final ProductModel product;
  final void Function() onSubmit;
  final void Function() onPrevios;

  const ConfirmCreate({
    super.key,
    required this.product,
    required this.onSubmit,
    required this.onPrevios,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "ยืนยันการเพิ่มสินค้า",
              style: CustomTextTheme.titleBold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: ColorTheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 200,
            child: product.image != null
                ? Image.file(
                    File(product.image ?? ""),
                  )
                : const Icon(
                    Icons.local_drink_outlined,
                    size: 40,
                    color: ColorTheme.primary,
                  ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetX<CategoryController>(
                  init: CategoryController(),
                  builder: (controller) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          showTextWithTitle(
                              title: "ประเภทสินค้า",
                              text: mappingCategory(
                                  product.category, controller.categoryList)),
                          showTextWithTitle(
                              title: "รหัสสินค้า", text: product.id.toString()),
                        ],
                      ),
                    );
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    product.name,
                    style: CustomTextTheme.subtitleBold.copyWith(
                      color: ColorTheme.primary,
                    ),
                  ),
                ),
                product.description != null && product.description!.isNotEmpty
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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ข้อมูลคลังสินค้า",
                  style: CustomTextTheme.bodyBold,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      showTextWithTitle(
                          title: "จํานวนสินค้า",
                          text: "${product.quantity} ชิ้น"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomButton(
                    buttonName: "ย้อนกลับ",
                    margin: const EdgeInsets.only(right: 20),
                    onPressed: onPrevios,
                    type: ButtonType.secondary,
                    status: ButtonStatus.primary,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CustomButton(
                    buttonName: "ยืนยัน",
                    onPressed: onSubmit,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showTextWithTitle({required String title, required String text}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: CustomTextTheme.bodyMedium),
          Text(text, style: CustomTextTheme.body),
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
