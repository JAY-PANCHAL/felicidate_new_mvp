import 'package:get/get.dart';

import '../main.dart';
import '../ui/screens/auth/login_screen.dart';
import '../ui/screens/auth/phoneLogin/phoneOtp/phone_otp_screen.dart';
import '../ui/screens/auth/phoneLogin/phone_login_screen.dart';

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

    GetPage(
        name: Routes.phoneLoginScreen,
        page: () => PhoneLoginScreen(),
        transition: Transition.rightToLeft),

    GetPage(
        name: Routes.phoneOtpScreen,
        page: () => PhoneOtpScreen(),
        transition: Transition.rightToLeft),

  ];
}
