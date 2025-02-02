import 'package:get/get.dart';

import '../main.dart';
import '../ui/screens/auth/login_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    // GetPage(
    //     name: Routes.splash,
    //     page: () => Splash(),
    //     transition: Transition.fade),

    GetPage(
        name: Routes.splash,
        page: () => LoginScreen(),
        transition: Transition.rightToLeft),

  ];
}
