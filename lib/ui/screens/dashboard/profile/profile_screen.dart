import 'package:felicidade/ui/screens/dashboard/profile/profile_controller.dart';
import 'package:felicidade/ui/widget/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../common/utils/app_constants.dart';
import '../../../../common/utils/Styles.dart';
import '../../../../common/utils/image_paths.dart';
import '../../../../common/utils/shared_pref_utils.dart';
import '../../../../common/utils/strings.dart';
import '../../../../routes/app_pages.dart';
import '../../../widget/common_widgets.dart';
import '../../../widget/image_view.dart';






class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<ProfileController>();
  }



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Obx(() {
      return ModalProgressHUD(
        color: Colors.black.withOpacity(0.6),
        dismissible: false,
        progressIndicator: AppConstants.loader(context),
        inAsyncCall: profileController.isLoading.value,
        child: Scaffold(
          backgroundColor: WHITE,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 12.h),
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(16),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFFFF5F7),
                              Color(0xFFFFE0E6),
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ImageView(
                              width: 70.sp,
                              height: 70.sp,
                              boxFit: BoxFit.contain,
                              image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIAKJjhk78An0TpKzc9w-bleEFdUxvNvc-82mUA6JaqIeSssy_YHD4Zjo&s",
                              imageShape: ImageShape.oval,
                              imageType: ImageType.network,
                            ),
                            SizedBox(width: 10.w,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Hi Rohit",style: Styles.textFontBold(size: 20,fontFamily: AppConstants.fontFamilyOgg,),),
                                Text("rkadam0123@gmail.com",style: Styles.textFontRegular(size: 14,color: GREY_COLOR),),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 5.w),
                        child: Icon(Icons.chevron_right_sharp),
                      )
                    ],
                  ),
                  SizedBox(height: 20.h,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ImageView(
                          width: 25.sp,
                          height: 25.sp,
                          boxFit: BoxFit.contain,
                          image: AppSvgIcons.lanuageIcon,
                          imageType: ImageType.svg,
                        ),
                        SizedBox(width: 13.w,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Strings.language,style: Styles.textFontBold(size: 16),),
                            Text(Strings.english,style: Styles.textFontRegular(size: 16,color: DIVIDER_COLOR),),
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(height: 20.h,color: LIGHT_GREEN,thickness: 1.5,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ImageView(
                          width: 25.sp,
                          height: 25.sp,
                          boxFit: BoxFit.contain,
                          image: AppSvgIcons.countryIcon,
                          imageType: ImageType.svg,
                        ),
                        SizedBox(width: 13.w,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Strings.country,style: Styles.textFontBold(size: 16),),
                            Text(Strings.india,style: Styles.textFontRegular(size: 16,color: DIVIDER_COLOR),),
                          ],
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      showConfirmAlertDialog(
                          Strings.logoutMessage,
                          Strings.yes,
                          Strings.no,
                          context: context,
                          positiveButtonClick: () {
                        onLogout();
                        Get.offNamedUntil(Routes.splash, (route) => false);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 12.h),
                      decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(16),
                          color: LIGHT_GREEN
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ImageView(
                            width: 25.sp,
                            height: 25.sp,
                            boxFit: BoxFit.contain,
                            image: AppSvgIcons.logOutIcon,
                            imageType: ImageType.svg,
                          ),
                          SizedBox(width: 13.w,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Strings.logoutSignOut,style: Styles.textFontBold(size: 16),),
                              Text(Strings.logoutOfOurApp,style: Styles.textFontRegular(size: 16,color: DIVIDER_COLOR),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }


}
