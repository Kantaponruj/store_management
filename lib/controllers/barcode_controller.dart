import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  var barcodeValue = ''.obs;

  void updateBarcodeValue(String newValue) {
    barcodeValue.value = newValue;
  }
}

class BluetoothScanner {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final BluetoothController _bluetoothController =
      Get.put(BluetoothController());

  BluetoothScanner() {
    _init();
  }

  void _init() async {
    flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        if (result.device.name == 'YourBarcodeScannerName') {
          result.device.connect();
          _listenForBarcodeData(result.device);
        }
      }
    });
  }

  void _listenForBarcodeData(BluetoothDevice device) {
    device.services.listen((List<BluetoothService> services) {
      for (BluetoothService service in services) {
        if (service.uuid.toString() == 'YourServiceUUID') {
          for (var characteristic in service.characteristics) {
            if (characteristic.uuid.toString() == 'YourCharacteristicUUID') {
              characteristic.setNotifyValue(true);
              characteristic.value.listen((List<int> value) {
                // Assuming barcode data is sent as string
                String barcodeData = String.fromCharCodes(value);
                _bluetoothController.updateBarcodeValue(barcodeData);
              });
            }
          }
        }
      }
    });
  }
}
