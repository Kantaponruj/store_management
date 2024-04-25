// Flutter imports:
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:promptpay_qrcode_generate/promptpay_qrcode_generate.dart';
import 'package:store_management/screens/product_page.dart';
import 'package:store_management/shared/theme/color_theme.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../shared/theme/text_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String? _barcode;
  bool visible = true;

  // void _incrementCounter() {
  //   setState(() {
  //     _barcode = null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    List<MenuItem> menuItems = [
      MenuItem(
        icon: Icons.inventory_outlined,
        title: "สินค้าทั้งหมด",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const ProductPage();
              },
            ),
          );
        },
      )
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 150,
          color: ColorTheme.white,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: ColorTheme.primary,
                foregroundColor: ColorTheme.white,
                child: Icon(Icons.person_outline_outlined),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Hello", style: CustomTextTheme.titleBold),
                    Text("John Doe", style: CustomTextTheme.body),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Menu",
                  style: CustomTextTheme.titleBold,
                ),
              ),
              Wrap(
                children: menuItems
                    .map((e) => menuCard(
                          title: e.title,
                          icon: e.icon,
                          onTap: e.onTap,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
        VisibilityDetector(
          onVisibilityChanged: (VisibilityInfo info) {
            visible = info.visibleFraction > 0;
          },
          key: const Key('visible-detector-key'),
          child: BarcodeKeyboardListener(
            bufferDuration: const Duration(milliseconds: 200),
            onBarcodeScanned: (barcode) {
              if (!visible) return;
              debugPrint(barcode);
              // setState(() {
              //   _barcode = barcode;
              // });
            },
            useKeyDownEvent: Platform.isWindows,
            child: Visibility(
              visible: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'BARCODE: ',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Center(
                    child: QRCodeGenerate(
                      isShowAccountDetail: false,
                      isShowAmountDetail: false,
                      promptPayId: "0939529954",
                      amount: 500.56,
                      width: 200,
                      height: 200,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget menuCard(
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: ColorTheme.primary,
        child: SizedBox(
          height: 150,
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: ColorTheme.white,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Text(
                  title,
                  style: CustomTextTheme.bodyBold.copyWith(
                    color: ColorTheme.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  MenuItem({required this.title, required this.icon, required this.onTap});
}
