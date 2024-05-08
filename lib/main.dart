// Flutter imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store_management/constants/firebase_auth_constants.dart';
import 'package:store_management/shared/theme/design_system.dart';
import 'package:store_management/utils/routes.dart';

// Project imports:
import 'controllers/auth_controller.dart';

Future<void> main() async {
  await GetStorage.init();
  await GetStorage.init("Settings");

  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialization.then((value) {
    Get.put(AuthController());
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: designSystem,
      debugShowCheckedModeBanner: false,
      title: 'Mile RMS',
      getPages: appRoutes(),
      home: const CircularProgressIndicator(),
    );
  }
}
