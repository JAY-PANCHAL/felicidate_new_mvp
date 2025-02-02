import 'package:get/get.dart';

import '../main.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
        name: Routes.splash,
        page: () => MyApp(),
        transition: Transition.fade),
    // GetPage(
    //     name: Routes.login,
    //     page: () => LoginScreen(),
    //     transition: Transition.rightToLeft),
    // GetPage(
    //     name: Routes.welcome,
    //     page: () => WelcomeScreen(),
    //     transition: Transition.rightToLeft),
  ];
}
