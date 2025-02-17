import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common/utils/shared_pref_utils.dart';
import '../../../controller/base_controller.dart';
import '../../../routes/app_pages.dart';

class SplashController extends BaseController {


  @override
  Future<void> onInit() async {
    super.onInit();


  }


  navigateToNextScreen(context) async {

    var isFirstTime = getIsFirsTime();
    if(isFirstTime==true){
      onLogout();
      setIsFirsTime(false);
    }

    var duration = const Duration(seconds: 2,);

    Timer(duration, () async {
      var loginData = await getUser();
      if (loginData==null) {
        Get.offNamedUntil(Routes.dashboard,(route) => false);
      } else {
        print('location--${loginData.cityLocation??''}');
        if((loginData.cityLocation??"")==""){
          Get.offNamedUntil(Routes.oneOnboardingScreen,(route) => false);
        }
        else{
            Get.offNamedUntil(Routes.dashboard,(route) => false);
        }

      }

    });


  }



}
