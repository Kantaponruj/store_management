import 'package:get/get.dart';
import 'package:store_management/screens/home_page.dart';
import 'package:store_management/screens/main_page.dart';
import 'package:store_management/screens/payment_page.dart';
import 'package:store_management/screens/pos_page.dart';
import 'package:store_management/screens/product_page.dart';
import 'package:store_management/screens/profile_page.dart';

appRoutes() => [
      GetPage(
        name: '/',
        page: () => const MainPage(),
      ),
      GetPage(
        name: '/home',
        page: () => const HomePage(),
        middlewares: [MyMiddelware()],
      ),
      GetPage(
        name: '/pos',
        page: () => const POSPage(),
        middlewares: [MyMiddelware()],
      ),
      GetPage(
        name: '/product',
        page: () => const ProductPage(),
        middlewares: [MyMiddelware()],
      ),
      GetPage(
        name: '/payment',
        page: () => const PaymentPage(),
        middlewares: [MyMiddelware()],
      ),
      GetPage(
        name: '/profile',
        page: () => const ProfilePage(),
      )
    ];

class MyMiddelware extends GetMiddleware {}
