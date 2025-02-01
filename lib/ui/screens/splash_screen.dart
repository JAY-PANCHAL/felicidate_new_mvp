import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/utils/color_constants.dart';
import '../../common/utils/dimensions.dart';
import '../../common/utils/image_paths.dart';
import '../../controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashController = Get.put(SplashController());

  @override
  void initState() {
    //  getData();
    super.initState();
  }

  /* getData() async {
    await splashController.getTokenApi();
  }
*/
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.width;
    var width = MediaQuery.of(context).size.height;

    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        //color: AppColors.appColor.shade800,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Color(0xFF143FB0), // Hex color
            ],
            begin: Alignment.topLeft, // Start point of the gradient
            end: Alignment.bottomRight, // End point of the gradient
          ),
        ),
        child: Image.asset(
          AppIcons.logo,
          height: height,
          width: width,
        ));
  }
}
