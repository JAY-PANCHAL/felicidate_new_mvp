
import 'package:felicidade/common/utils/image_paths.dart';
import 'package:felicidade/ui/screens/splash/splash_controller.dart';
import 'package:felicidade/ui/widget/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../common/utils/app_constants.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}
class SplashScreenState extends State<SplashScreen> {


  final SplashController splashController = Get.put(SplashController());

  @override
  void initState() {
    splashController.navigateToNextScreen(context);
    super.initState();
  }


  @override
  void dispose() {

    super.dispose();
    Get.delete<SplashController>();
  }



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: WHITE,
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppPngIcons.spashLogo),fit: BoxFit.fill)
        ),
      ),
    );
  }


}
