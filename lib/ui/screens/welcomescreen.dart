import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/rounded_button.dart';
import '../../common/utils/app_constants.dart';
import '../../common/utils/color_constants.dart';
import '../../common/utils/image_paths.dart';
import '../../common/utils/utility.dart';
import '../../routes/app_pages.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.width;
    var width = MediaQuery.of(context).size.height;

    return Container(
/*
        color: AppColors.white,
*/
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red,
              Colors.white,
              Color(0xFF143FB0), // Hex color
            ],
            begin: Alignment.topLeft, // Start point of the gradient
            end: Alignment.bottomRight, // End point of the gradient
          ),
        ),
        child: Column(
          children: [
            Spacer(),
            Image.asset(
              AppIcons.logo,
              width: width / 2,
              height: height / 3,
            ),
            Spacer(),
            RoundedButton(
                buttonText: AppConstants.login.toUpperCase(),
                height: 44,
                color: AppColors.appColor.shade800,
                width: width / 3,
                onpressed: () {
                  Get.offAllNamed(Routes.login);
                }),
            Utils.addGap(20),
            RoundedButton(
                buttonText: AppConstants.register.toUpperCase(),
                height: 44,
                color: AppColors.appColor.shade200,
                width: width / 3,
                onpressed: () {
                  Get.offAllNamed(Routes.login);
                }),
            Utils.addGap(20)
          ],
        ));
  }
}
