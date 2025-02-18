import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:felicidade/common/utils/Styles.dart';
import 'package:felicidade/common/utils/image_paths.dart';
import 'package:felicidade/routes/app_pages.dart';
import 'package:felicidade/ui/widget/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../common/utils/app_constants.dart';
import '../../../common/utils/strings.dart';
import '../../widget/image_view.dart';
import 'login_controller.dart';
import 'dart:math' as math;

/// Generates a cryptographically secure random nonce of the specified length.
/// Defaults to 32 characters, which is recommended for most use cases.
String generateNonce([int length = 32]) {
  final charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = math.Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final List<String> imageUrls = List.generate(19, (index) {
    return 'assets/icons/pngIcons/a${index + 1}.jpg';
  });

  late ScrollController _scrollController1;
  late ScrollController _scrollController2;
  late ScrollController _scrollController3;
  final _auth = FacebookAuth.instance;
  String? _nonce;

  Timer? _timer1;
  Timer? _timer2;
  Timer? _timer3;

  final LoginController loginController = Get.put(LoginController());

  Future<void> _getUserProfile(AccessToken accessToken) async {
    if (accessToken is LimitedToken) {
      print('token nonce: ${accessToken.nonce}');
      print('_nonce: $_nonce');
    } else {
      print('accessToken is ClassicToken');
    }

    final data = await _auth.getUserData();
    print("Facebook Data--------------->");
    print(data);
    FacebookUser user = FacebookUser.fromJson(data);
    loginController.apiCallForFBSignIn(context, user, accessToken);

    if (data.isEmpty) {
      await _logout();
      return;
    }
  }

  Future<void> _logout() async {
    await _auth.logOut();
  }

  Future<void> fblogin() async {
    _nonce = generateNonce();
    print("facebook button clicked");
    final result = await _auth.login(
      loginTracking: LoginTracking.limited,
      nonce: _nonce,
    );

    switch (result.status) {
      case LoginStatus.success:
        await _getUserProfile(result.accessToken!);
      case LoginStatus.cancelled:
      case _:
        print(
          '${result.status.name}: ${result.message}',
        );
    }
  }

  @override
  void initState() {
    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();
    _scrollController3 = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
    loginController.getCurrentLocation();
    super.initState();
  }

  Future facebookLogin() async {
    final result =
        await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.i.getUserData();
      print(userData);
      return userData;
    }
    return null;
  }

  void _startScrolling() {
    _timer1 = Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (_scrollController1.hasClients &&
          _scrollController1.position.hasContentDimensions) {
        _scrollController1.jumpTo(_scrollController1.offset + 1);
        if (_scrollController1.offset >=
            _scrollController1.position.maxScrollExtent) {
          _scrollController1.jumpTo(0);
        }
      }
    });

    _timer2 = Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (_scrollController2.hasClients &&
          _scrollController2.position.hasContentDimensions) {
        _scrollController2.jumpTo(_scrollController2.offset - 1);
        if (_scrollController2.offset <=
            _scrollController2.position.minScrollExtent) {
          _scrollController2
              .jumpTo(_scrollController2.position.maxScrollExtent);
        }
      }
    });

    _timer3 = Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (_scrollController3.hasClients &&
          _scrollController3.position.hasContentDimensions) {
        _scrollController3.jumpTo(_scrollController3.offset + 1);
        if (_scrollController3.offset >=
            _scrollController3.position.maxScrollExtent) {
          _scrollController3.jumpTo(0);
        }
      }
    });
  }

  @override
  void dispose() {
    // Dispose controllers and timers to avoid memory leaks
    _scrollController1.dispose();
    _scrollController2.dispose();
    _scrollController3.dispose();
    _timer1?.cancel();
    _timer2?.cancel();
    _timer3?.cancel();
    super.dispose();
    Get.delete<LoginController>();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Obx(() {
      return ModalProgressHUD(
        color: Colors.black.withOpacity(0.6),
        dismissible: false,
        progressIndicator: AppConstants.loader(context),
        inAsyncCall: loginController.isLoading.value,
        child: Scaffold(
          backgroundColor: WHITE,
          body: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // First Column (scrolls down to up)
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController1,
                      itemCount: imageUrls.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 50,
                          height: 130.h,
                          margin: EdgeInsets.all(5),
                          child: Image.asset(
                            imageUrls[index],
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController2,
                      itemCount: imageUrls.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 50,
                          height: 130.h,
                          margin: EdgeInsets.all(5),
                          child: Image.asset(
                            imageUrls[index],
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController3,
                      itemCount: imageUrls.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 50,
                          height: 130.h,
                          margin: EdgeInsets.all(5),
                          child: Image.asset(
                            imageUrls[index],
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Container(
                color: Color(0xFF006FA3).withOpacity(0.6),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 23.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      Text(
                        Strings.felicidade,
                        style: Styles.textFontBold(
                            size: 50,
                            color: WHITE,
                            fontFamily: AppConstants.fontFamilyOgg),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        Strings.findYourTribe,
                        style: Styles.textFontBold(size: 24, color: WHITE),
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      CommonButton(
                          icon: AppSvgIcons.googleSvg,
                          text1: Strings.signinWGoogle,
                          text2: "",
                          onTap: () async {
                            UserCredential userCredential =await signInWithGoogle();
                            if (userCredential.user?.email!=null){
/*
(userCredential.additionalUserInfo.profile['picture']);
*/
                              loginController.apiCallForGoogleSignIn(context, userCredential.user?.displayName??"", userCredential.user?.email??"",
                                  userCredential.credential?.accessToken??"",userCredential.user?.phoneNumber??"",userCredential.additionalUserInfo?.providerId??"",userCredential.additionalUserInfo!.profile?['picture']);

                            }
                              print(userCredential);

                          //  AppConstants.showToast(userCredential);
                          }),
                      CommonButton(
                          icon: AppSvgIcons.facBookIcon,
                          text1: Strings.signIn,
                          text2: " ${Strings.withFacebook}",
                          onTap: () async {
                            await fblogin();
                          }),
                      CommonButton(
                          icon: AppSvgIcons.phoneIcon,
                          text1: "",
                          text2: Strings.useMobileNumber,
                          onTap: () {
                            Get.toNamed(Routes.phoneLoginScreen);
                            // Get.toNamed(Routes.dashboard);
                          }),
                      SizedBox(
                        height: 35.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget CommonButton({String? icon, String? text1, String? text2, onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 43.h,
        width: 1.sw,
        margin: EdgeInsets.symmetric(vertical: 6.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: WHITE,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageView(
              width: 25.sp,
              height: 25.sp,
              boxFit: BoxFit.contain,
              image: icon ?? AppSvgIcons.googleSvg,
              imageType: ImageType.svg,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: text1 ?? '',
                  style: Styles.textFontMedium(size: 16, color: GREY_COLOR),
                ),
                TextSpan(
                  text: text2 ?? "",
                  style: Styles.textFontMedium(size: 16),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }


  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
  }
}
