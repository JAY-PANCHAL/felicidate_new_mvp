import 'package:felicidade/common/utils/color_constants.dart';
import 'package:felicidade/common/utils/image_paths.dart';
import 'package:felicidade/ui/screens/dashboard/journaling/journaling_dashboard_controller.dart';
import 'package:felicidade/ui/widget/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../common/utils/app_constants.dart';
import '../../../../common/utils/Styles.dart';
import '../../../../common/utils/strings.dart';
import '../../../../routes/app_pages.dart';
import '../../../widget/image_view.dart';

class JournalingDashboard extends StatefulWidget {
  const JournalingDashboard({super.key});

  @override
  State<StatefulWidget> createState() => JournalingDashboardState();
}

class JournalingDashboardState extends State<JournalingDashboard> {
  final JournalingDashboardController jdController =
      Get.put(JournalingDashboardController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<JournalingDashboardController>();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Obx(() {
      return ModalProgressHUD(
          color: Colors.black.withOpacity(0.6),
          dismissible: false,
          progressIndicator: AppConstants.loader(context),
          inAsyncCall: jdController.isLoading.value,
          child: Scaffold(
            backgroundColor: WHITE,
            body: Container(
                height: 1.sh,
                width: 1.sw,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFF5F8),
                      Color(0xFFF5FBFD),
                      Color(0xFFF8F6E6),
                    ],
                  ),
                ),
                child: SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        Text(Strings.forAddingYourMoments,
                            textAlign: TextAlign.center,
                            style: Styles.textFontMedium(
                              fontFamily: AppConstants.fontFamilyOgg,
                              size: 22,
                            )),
                        SizedBox(
                          height: 10.h,
                        ),
                        InkWell(
                          onTap: (){
                            Get.toNamed(Routes.createNewStoryScreen);
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 25.h),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.appColor,
                                      blurRadius: 0.3,
                                      blurStyle: BlurStyle.outer)
                                ],
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFFFF5F7),
                                    Color(0xFFFFF5F7),
                                  ],
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ImageView(
                                    image: AppSvgIcons.icCreateNote,
                                    imageType: ImageType.svg,
                                    width: 28,
                                    height: 28,
                                  ),
                                  SizedBox(
                                    width: 10.h,
                                  ),
                                  Text(Strings.createAnewStory,
                                      style: Styles.textFontMedium(
                                        fontFamily: AppConstants.fontFamilyOgg,
                                        size: 18,
                                      )),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 25.h),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.appColor,
                                  blurRadius: 0.3,
                                  blurStyle: BlurStyle.outer)
                            ],
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFFFF5F7),
                                Color(0xFFFFF5F7),
                              ],
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(Strings.feelingsLongText,
                                  textAlign: TextAlign.center,
                                  style: Styles.textFontMedium(
                                    fontFamily: AppConstants.fontFamilyOgg,
                                    size: 16,
                                  )),
                            ],
                          ),
                        )
                      ]),
                ))),
          ));
    });
  }
}
