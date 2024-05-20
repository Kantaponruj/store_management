import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_management/controllers/category_controller.dart';
import 'package:store_management/screens/components/custom_text_fields.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("หมวดหมู่"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GetX<CategoryController>(
              builder: (controller) {
                final list = controller.categoryList;
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(list[index].name),
                      );
                    });
              },
            ),
            const SizedBox(
              width: 500,
              child: Column(
                children: [
                  CustomTextField(
                      props: CustomTextFieldProps(
                    topic: "รหัสหมวดหมู่",
                  )),
                  CustomTextField(
                      props: CustomTextFieldProps(
                    topic: "ชื่อหมวดหมู่",
                  )),
                  CustomTextField(
                      props: CustomTextFieldProps(
                    topic: "รายละเอียดหมวดหมู่",
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
