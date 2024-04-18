// Flutter imports:
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:promptpay_qrcode_generate/promptpay_qrcode_generate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _barcode;
  late bool visible;

  // void _incrementCounter() {
  //   setState(() {
  //     _barcode = null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
              setState(() {
                _barcode = barcode;
              });
            },
            useKeyDownEvent: Platform.isWindows,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  _barcode == null ? 'SCAN BARCODE' : 'BARCODE: $_barcode',
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
      ],
    );
  }
}
