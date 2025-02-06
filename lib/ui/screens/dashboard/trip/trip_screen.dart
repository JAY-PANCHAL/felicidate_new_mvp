import 'package:felicidade/common/utils/image_paths.dart';
import 'package:felicidade/ui/screens/dashboard/profile/profile_controller.dart';
import 'package:felicidade/ui/widget/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../common/utils/app_constants.dart';
import '../../../../common/utils/Styles.dart';
import '../../../../common/utils/strings.dart';
import '../../../widget/image_view.dart';
import 'trip_controller.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<StatefulWidget> createState() => TripScreenState();
}

class TripScreenState extends State<TripScreen> {
  final TripController tripController = Get.put(TripController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<TripController>();
  }



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Obx(() {
      return ModalProgressHUD(
        color: Colors.black.withOpacity(0.6),
        dismissible: false,
        progressIndicator: AppConstants.loader(context),
        inAsyncCall: tripController.isLoading.value,
        child: Scaffold(
          backgroundColor: WHITE,
          body: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 1.sh * 0.55,
                    width: 1.sw,
                    margin: EdgeInsets.only(bottom: 10.h),
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(AppPngIcons.tripBackIcon),fit: BoxFit.fill)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 40.h,),
                        ImageView(
                          width: 80.sp,
                          height: 80.sp,
                          boxFit: BoxFit.contain,
                          image: AppSvgIcons.tripMainIcon,
                          imageType: ImageType.svg,
                        ),
                        SizedBox(height: 15.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text("We’re coming to you Freak my trip!!",style: Styles.textFontBoldHeight(
                              size: 28,
                              color: COFFIE_COLOR,
                              fontFamily: AppConstants.fontFamilyOgg),
                            textAlign: TextAlign.center,),
                        ),
                        SizedBox(height: 15.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text("We’re going to launch Freak my trip\nsoon. Stay tune.",style: Styles.textFontRegular(
                              size: 18,),
                            textAlign: TextAlign.center,),
                        ),

                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 7.h,horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: BLACK_COLOR3,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ImageView(
                          width: 25.sp,
                          height: 25.sp,
                          boxFit: BoxFit.contain,
                          image: AppSvgIcons.notifyMeIcon,
                          imageType: ImageType.svg,
                        ),
                        SizedBox(width: 10.w,),
                        Text(Strings.NotifyMe,style: Styles.textFontRegular(size: 14,color: WHITE),),
                        Icon(Icons.chevron_right_outlined,color: WHITE,)
                      ],
                    ),
                  )
                ],
              ),


            ],
          ),
        ),
      );
    });
  }


}
