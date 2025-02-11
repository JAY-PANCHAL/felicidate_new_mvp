import 'package:felicidade/ui/screens/dashboard/journaling/create_story_screen.dart';
import 'package:felicidade/ui/screens/dashboard/journaling/journaling_dashboard.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../ui/screens/auth/login_screen.dart';
import '../ui/screens/auth/onboarding/onboarding1/one_onboarding_screen.dart';
import '../ui/screens/auth/onboarding/onboarding2/two_onboarding_screen.dart';
import '../ui/screens/auth/onboarding/onboarding3/three_onboarding_screen.dart';
import '../ui/screens/auth/phoneLogin/phoneOtp/phone_otp_screen.dart';
import '../ui/screens/auth/phoneLogin/phone_login_screen.dart';
import '../ui/screens/dashboard/dashboard_Screen.dart';

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
    GetPage(
        name: Routes.dashboard,
        page: () => DashboardScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.oneOnboardingScreen,
        page: () => OneOnboardingScreen(),
        transition: Transition.rightToLeft),

    GetPage(
        name: Routes.twoOnboardingScreen,
        page: () => TwoOnboardingScreen(),
        transition: Transition.rightToLeft),

    GetPage(
        name: Routes.threeOnboardingScreen,
        page: () => ThreeOnboardingScreen(),
        transition: Transition.rightToLeft),

    GetPage(
        name: Routes.journalingDashboard,
        page: () => JournalingDashboard(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.createNewStoryScreen,
        page: () => CreateNewStoryScreen(),
        transition: Transition.rightToLeft),
  ];
}
