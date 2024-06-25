import 'package:get_storage/get_storage.dart';

final settings = GetStorage("Settings");
final bool isPhone = settings.read('isPhone') ?? false;
