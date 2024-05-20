import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

Future<void> startBarcodeScanStream({void Function(dynamic)? onScan}) async {
  FlutterBarcodeScanner.getBarcodeStreamReceiver(
    "#ff6666",
    "Cancel",
    false,
    ScanMode.BARCODE,
  )!
      .listen(
    (barcode) {
      onScan;
    },
  );
}

Future<String> startBarcodeScan() async {
  final result = await FlutterBarcodeScanner.scanBarcode(
    "#ff6666",
    "Cancel",
    false,
    ScanMode.BARCODE,
  );

  return result;
}
