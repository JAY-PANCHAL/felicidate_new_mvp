import 'dart:convert';
import 'dart:io';
import 'package:felicidade/common/utils/storage_service.dart';
import 'package:felicidade/common/utils/strings.dart';
import 'package:felicidade/ui/widget/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../network/model/user_model.dart';
import '../../routes/app_pages.dart';
import '../../ui/widget/image_view.dart';
import 'Styles.dart';
import 'app_constants.dart';
import 'color_constants.dart';
import 'dimensions.dart';
import 'image_paths.dart';

class AppConstants {

  static const String fontFamilySatoshi = "Satoshi";
  static const String fontFamilyOgg = "Ogg";


  static String getCurrentTimeFormatted() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm').format(now);
    return formattedTime;
  }

  static void showSnackBar(error, context, onRetry) {
    final snackBar = SnackBar(
      backgroundColor: Colors.black,
      content: Text(error),
      duration: const Duration(hours: 1),
      action: SnackBarAction(
        label: 'Retry',
        onPressed: () {
          onRetry();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static String getDeviceType() {
    //1 for iOS, 2 for Android
    if (Platform.isIOS) {
      // import 'dart:io'
      return "1";
    } else {
      return "2";
    }
  }

  static loader(context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 1.sh,
        width: 1.sw,
        child: Container(
          decoration: BoxDecoration(
            color: WHITE,
            image: DecorationImage(image: AssetImage(AppPngIcons.loadingScreenIcon),fit: BoxFit.cover)
          ),
        )
      ),
    );
  }


  static loaderCircular(context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 1.sh,
        width: 1.sw,
        color: Colors.black.withOpacity(0.6),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50.h)),
            child: const Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.blue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static bool isEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static Widget? hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    return null;
  }

  static showToast(message) => Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 15.0);

  static String convertiEnDateEtHeure(n) {
    String date = DateFormat('yyyy-MM-dd').format(n);
    return date;
  }

  void snackBar(String msg, BuildContext context) {
    var snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }



  static Widget buildProgressIndicator() {
    return Container(
      height: Dimensions.screenHeight,
      color: AppColors.black.withOpacity(0.4),
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: AppColors.blue,
          valueColor: new AlwaysStoppedAnimation<Color>(AppColors.white),
        ),
      ),
    );
  }



  static addSmallGap10() {
    return SizedBox(
      height: 10.sp,
    );
  }

  static addSmallGap5() {
    return SizedBox(
      height: 5,
    );
  }

  static addGap15() {
    return SizedBox(
      height: 15.sp,
    );
  }

  static addMediumGap() {
    return SizedBox(
      height: 20.sp,
    );
  }

  static addGap(int size) {
    return SizedBox(
      height: size.sp,
    );
  }

  static addHGap(int size) {
    return SizedBox(
      width: size.sp,
    );
  }

  static checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static addLargeGap() {
    return SizedBox(
      height: 30.sp,
    );
  }




  static svgFile({fileName, height, width, color}) => SvgPicture.asset(
        fileName,
        height: height,
        width: width,
        color: color,
      );

  static svgFileWithoutColor({fileName, height, width}) => SvgPicture.asset(
        fileName,
        height: height,
        width: width,
      );

  static void getDeleteNotificationDialog(context, onYesPressed, onNoPressed) {
    Platform.isAndroid
        ? Get.dialog(
            AlertDialog(
              title: Text('Are you sure you want to delete this notification?'),
              actions: [
                TextButton(
                    child: Text(Strings.yes),
                    onPressed:
                        onYesPressed /*() {
              Navigator.of(Get.overlayContext!, rootNavigator: true)
                  .pop(Strings.logout);                    //  Get.back();

            },*/
                    ),
                TextButton(
                  child: Text(Strings.no),
                  onPressed:
                      onNoPressed, /* () {
              Navigator.of(Get.overlayContext!, rootNavigator: true)
                  .pop(Strings.logout);                  },*/
                ),
              ],
            ),
            barrierDismissible: false,
          )
        : Get.dialog(
            CupertinoAlertDialog(
              title: Text('Are you sure you want to logout?'),
              actions: [
                CupertinoDialogAction(
                  child: Text(Strings.yes),
                  onPressed: onYesPressed,
                ),
                CupertinoDialogAction(
                  child: Text(Strings.no),
                  onPressed: onNoPressed,
                )
              ],
            ),
            barrierDismissible: false,
          );
  }

  static Widget callWidget(String phonenumber, Widget commonwidget) {
    return GestureDetector(
      onTap: () async {
        await launchPhone(phonenumber);
      },
      child: commonwidget,
    );
  }


  static Widget emailWidget(String email, Widget commonwidget) {
    return GestureDetector(
      onTap: () async {
        await launchEmail(email);
      },
      child: commonwidget,
    );
  }

  static Future<void> launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Could not launch $emailUri';
    }
  }

  // Function to launch phone dialer
  static Future<void> launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  static CommonFloatButton({onTap}){
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: ImageView(
        width: 75.sp,
        height: 75.sp,
        boxFit: BoxFit.contain,
        image: AppSvgIcons.icFloatButtonIcon,
        imageType: ImageType.svg,
      ),
    );
  }

  static CommonProgressIndicator({Color color = DIVIDER_COLOR ,double value = 0.0}){
    return  ClipRRect(
      borderRadius: BorderRadius.circular(8.0), // Set border radius here
      child: LinearProgressIndicator(
        value: value, // Set progress value here (0.0 to 1.0)
        minHeight: 7.0, // Height of the progress bar
        backgroundColor: LIGHT_GREY_COLOR,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }

  static CommonButtom({String? text, onTap}){
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        height: 45.h,
        width: 1.sw,
        margin: EdgeInsets.symmetric(horizontal: 25.w,vertical: 10.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                PRIMARY_COLOR_GRA1,
                PRIMARY_COLOR_GRA2,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: GREY_COLOR.withOpacity(0.2), // Shadow color
                spreadRadius: 0, // Slight spread to keep the shadow subtle
                blurRadius: 2, // Increased blur for a softer shadow
                offset: Offset(0, 4), // Shadow appears below (positive y-axis)
              ),
            ],
            borderRadius: BorderRadius.circular(30)
        ),
        child: Text(text??"",style: Styles.textFontMedium(size: 16),),
      ),
    );
  }

}
