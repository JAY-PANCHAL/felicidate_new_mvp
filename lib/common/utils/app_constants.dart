import 'dart:convert';
import 'dart:io';
import 'package:felicidade/common/utils/storage_service.dart';
import 'package:felicidade/common/utils/strings.dart';
import 'package:felicidade/ui/widget/constants/app_colors.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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


  static showGetSnackBar(titleText, message, color) {
    Get.closeCurrentSnackbar();
    if (Get.isSnackbarOpen == true) {
      Get.closeAllSnackbars();
    }

    return Get.snackbar(
      'Success',
      message,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color,
      colorText: Colors.white,
      titleText: Text(
        titleText,
        style: Styles.textFontMedium(size: 12,color: WHITE),
      ),
      messageText: Text(
        message,
        style: Styles.textFontMedium(size: 10,color: WHITE),
      ),
    );
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
            color: WHITE.withOpacity(0.7),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children:[ ImageView(
                  width: 280.w,
                  height: 180.h,
                  boxFit: BoxFit.contain,
                  image: AppPngIcons.loaderText,
                  imageType: ImageType.asset,
                ),
                  Padding(
                    padding:  EdgeInsets.only(bottom: 35.h),
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(PRIMARY_COLOR),
                    ),
                  ),
                ]
              ),

            ],
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
      backgroundColor: BLUE_COLOR3,
      textColor: WHITE,
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


  static Widget CommonProgressIndicator2({
    LinearGradient gradient = const LinearGradient(
      colors: [Color(0xFF86D8FF), Color(0xFFFF9FB2), Color(0xFFFFD18E)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    double value = 0.0,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0), // Set border radius here
      child: Stack(
        children: [
          // Background gradient layer
          Container(
            height: 7.0, // Height of the progress bar
            decoration: BoxDecoration(
              gradient: gradient, // Apply gradient to the background
            ),
          ),
          // Foreground progress indicator layer
          LinearProgressIndicator(
            value: value, // Set progress value here (0.0 to 1.0)
            minHeight: 7.0, // Height of the progress bar
            backgroundColor: Colors.transparent, // Keep background transparent to show gradient
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withOpacity(0.8)), // Optional glow
          ),
        ],
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




// Common BoxShadow utility
  BoxShadow commonBoxShadow({
    Color color = GREY_COLOR, // Default shadow color
    double blurRadius = 10.0,  // Default blur radius
    double spreadRadius = 0.0, // Default spread radius
    Offset offset = const Offset(0, 0), // Default offset
  }) {
    return BoxShadow(
      color: color.withOpacity(0.2), // Adjust transparency
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      offset: offset,
    );
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    return "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  }

  String formatDateTimeString(String dateTimeString) {
    try{
      // Parse string to DateTime
      DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTimeString);

      // Months list
      const List<String> months = [
        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
      ];

      // Get day with suffix (1st, 2nd, 3rd, etc.)
      int day = dateTime.day;
      String suffix = "th";
      if (day % 10 == 1 && day != 11) suffix = "st";
      if (day % 10 == 2 && day != 12) suffix = "nd";
      if (day % 10 == 3 && day != 13) suffix = "rd";

      // Get formatted hour in 12-hour format
      int hour = dateTime.hour;
      String period = hour >= 12 ? "pm" : "am";
      int formattedHour = hour % 12 == 0 ? 12 : hour % 12;

      // Get formatted date
      String formattedDate =
          "${day}$suffix ${months[dateTime.month - 1]} • $formattedHour $period";
      return formattedDate;
    }
    catch(e){
      return "";
    }


  }

  Future<String?> getCityFromLatLong(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        return placemarks.first.locality; // Returns the city name
      }
    } catch (e) {
      print("Error fetching city: $e");
    }
    return "";
  }

  int calculateAge(DateTime selectedDate) {
    DateTime today = DateTime.now();
    int age = today.year - selectedDate.year;

    // Adjust age if the birthday hasn't occurred yet this year
    if (today.month < selectedDate.month ||
        (today.month == selectedDate.month && today.day < selectedDate.day)) {
      age--;
    }

    return age;
  }



}
