import 'package:felicidade/common/utils/image_paths.dart';
import 'package:felicidade/ui/widget/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../common/utils/app_constants.dart';
import '../../../../common/utils/Styles.dart';
import '../../../../common/utils/strings.dart';
import '../../../widget/image_view.dart';
import 'home_conroller.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<HomeController>();
  }



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Obx(() {
      return ModalProgressHUD(
        color: Colors.black.withOpacity(0.6),
        dismissible: false,
        progressIndicator: AppConstants.loader(context),
        inAsyncCall: homeController.isLoading.value,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.h,),
                    Text(Strings.helloUser,style: Styles.textFontBold(size: 26,fontFamily: AppConstants.fontFamilyOgg,)),
                    SizedBox(height: 20.h,),
                    feelingWidget(),
                    SizedBox(height: 20.h,),
                    feturesWidget(),
                    SizedBox(height: 20.h,),
                    Text(Strings.recentlyTalkedWith,style: Styles.textFontMedium(size: 16,)),
                    SizedBox(height: 10.h,),
                    recentlyTalkedWith(),
                    SizedBox(height: 20.h,),
                    Text(Strings.yourRecentJournalEntries,style: Styles.textFontMedium(size: 16,)),
                    SizedBox(height: 3.h,),
                    Text(Strings.findExpertsToTalk,style: Styles.textFontRegular(size: 10,)),
                    SizedBox(height: 10.h,),

                    yourRecentJournal(),
                    SizedBox(height: 10.h,),
                    yourRecentJournalList(),

                    SizedBox(height: 80.h,),



                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    );
  }

  Widget feelingWidget(){
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(vertical: 7.h,horizontal: 10.w),
      decoration: BoxDecoration(
        color: WHITE,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          AppConstants().commonBoxShadow()
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Strings.howAreYouFeeling,style: Styles.textFontBold(size: 14,)),
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              commonFeeling(icon: AppSvgIcons.fe1Icon),
              commonFeeling(icon: AppSvgIcons.fe2Icon),
              commonFeeling(icon: AppSvgIcons.fe3Icon),
              commonFeeling(icon: AppSvgIcons.fe4Icon),
              commonFeeling(icon: AppSvgIcons.fe5Icon),
            ],
          ),

        ],
      ),
    );
  }


  Widget commonFeeling({String? icon}){
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          AppConstants().commonBoxShadow(blurRadius: 5,color: DIVIDER_COLOR2)
        ]
      ),
      child: ImageView(
        width: 55.sp,
        height: 55.sp,
        boxFit: BoxFit.contain,
        image: icon??AppSvgIcons.fe1Icon,
        imageType: ImageType.svg,
      ),
    );
  }


  Widget recentlyTalkedWith(){
    return SizedBox(
      height: 1.sh * 0.316,
      child: ListView.separated(
        itemCount: 3,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 1.sw * 0.42,
            padding: EdgeInsets.symmetric(horizontal: 13.w,vertical: 13.h),
            decoration: BoxDecoration(
              color: WHITE,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                AppConstants().commonBoxShadow(color: LIGHT_GREY_COLOR2)
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 6.h),
                  decoration: BoxDecoration(
                      color: WHITE,
                      boxShadow: [
                        AppConstants().commonBoxShadow()
                      ],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: HOME_RED_LIGHT,width: 0.5)
                  ),
                  child: Text(Strings.feliFriend,style: Styles.textFontBold(size: 10,color:HOME_RED_LIGHT  ),),
                ),
                SizedBox(height: 8.h,),
                Text("Rohit Kadam",style: Styles.textFontMedium(size: 17,color:RED_DARK  ),),
                // SizedBox(height: 10.h,),
                Text("Lorem ipsum dolor sit amet consectetur. Magnis id.",style: Styles.textFontRegular(size: 10),),
                SizedBox(height: 5.h,),

                Text("24th Sep 2024  12:00 Min",style: Styles.textFontMedium(size: 10,color:RED_DARK  ),),

                SizedBox(height: 25.h,),

                Container(
                  width: 1.sw,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: HOME_RED_LIGHT2,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(Strings.callNow,style: Styles.textFontRegular(size: 10,color: RED_DARK  ),),
                ),
                SizedBox(height: 8.h,),
                Container(
                  width: 1.sw,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: WHITE,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: RED_DARK,width: 0.5)
                  ),
                  child: Text(Strings.feliFriend,style: Styles.textFontRegular(size: 10,color:RED_DARK  ),),
                ),

              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 10.w,);
        },
      ),
    );
  }

  Widget feturesWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 1.sw * 0.44,
              height: 1.sh * 0.28,
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              decoration: BoxDecoration(
                boxShadow: [
                  AppConstants().commonBoxShadow(color: LIGHT_GREY_COLOR2)
                ],
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFF5F7),
                    Color(0xFFFFE0E6),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h,),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 4.h),
                      decoration: BoxDecoration(
                          color: WHITE,
                          boxShadow: [
                            AppConstants().commonBoxShadow()
                          ],
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: HOME_RED_LIGHT,width: 0.5)
                      ),
                      child: Text(Strings.itFree  ,style: Styles.textFontBold(size: 10,color:HOME_RED_LIGHT  ),),
                    ),
                  ),
                  SizedBox(height: 15.h,),
                  Text(Strings.talkWithSomeone,style: Styles.textFontBoldHeight(size: 18,color: RED_DARK ,fontFamily: AppConstants.fontFamilyOgg),),
                  SizedBox(height: 5.h,),
                  ImageView(
                    width: 90.sp,
                    height: 90.sp,
                    boxFit: BoxFit.contain,
                    image: AppSvgIcons.talkIcon,
                    imageType: ImageType.svg,
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h,),
            Container(
              width: 1.sw * 0.44,
              height: 1.sh * 0.25,
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  AppConstants().commonBoxShadow(color: LIGHT_GREY_COLOR2)
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    WHITE,
                    WHITE,
                    LIGHT_GREY_COLOR2,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h,),
                  ImageView(
                    width: 90.sp,
                    height: 90.sp,
                    boxFit: BoxFit.contain,
                    image: AppSvgIcons.writeYourIcon,
                    imageType: ImageType.svg,
                  ),
                  SizedBox(height: 10.h,),
                  Text(Strings.writeYourThoughtsDown,style: Styles.textFontBoldHeight(size: 18,color: BLACK_COLOR3 ,fontFamily: AppConstants.fontFamilyOgg),),
                  SizedBox(height: 10.h,),
                ],
              ),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 1.sw * 0.44,
              height: 1.sh * 0.25,
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              decoration: BoxDecoration(
                boxShadow: [
                  AppConstants().commonBoxShadow(color: LIGHT_GREY_COLOR2)
                ],
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFEBFAFF),
                    Color(0xFFC6F2FF),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h,),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 4.h),
                      decoration: BoxDecoration(
                          color: WHITE,
                          boxShadow: [
                            AppConstants().commonBoxShadow()
                          ],
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: BLUE_COLOR3,width: 0.5)
                      ),
                      child: Text(Strings.comingSoon  ,style: Styles.textFontBold(size: 10,color:BLUE_COLOR3  ),),
                    ),
                  ),
                  SizedBox(height: 15.h,),
                  ImageView(
                    width: 65.sp,
                    height: 65.sp,
                    boxFit: BoxFit.contain,
                    image: AppSvgIcons.bookCallIcon,
                    imageType: ImageType.svg,
                  ),
                  SizedBox(height: 10.h,),
                  Text(Strings.bookCallWithExperts,style: Styles.textFontBoldHeight(size: 18,color: BLUE_COLOR3 ,fontFamily: AppConstants.fontFamilyOgg),),

                ],
              ),
            ),
            SizedBox(height: 12.h,),
            Container(
              width: 1.sw * 0.44,
              height: 1.sh * 0.28,
              padding: EdgeInsets.symmetric(horizontal: 13.w),

              decoration: BoxDecoration(
                boxShadow: [
                  AppConstants().commonBoxShadow(color: LIGHT_GREY_COLOR2)
                ],
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFF9EE),
                    Color(0xFFFFF2D8),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 4.h),
                    decoration: BoxDecoration(
                        color: WHITE,
                        boxShadow: [
                          AppConstants().commonBoxShadow()
                        ],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: YELLOW_COLOR,width: 0.5)
                    ),
                    child: Text(Strings.comingSoon  ,style: Styles.textFontBold(size: 10,color:YELLOW_COLOR  ),),
                  ),
                  SizedBox(height: 15.h,),
                  Text(Strings.startFreakingYourTrip,style: Styles.textFontBoldHeight(size: 18,color: YELLOW_COLOR ,fontFamily: AppConstants.fontFamilyOgg),),
                  SizedBox(height: 10.h,),

                  ImageView(
                    width: 65.sp,
                    height: 65.sp,
                    boxFit: BoxFit.contain,
                    image: AppSvgIcons.startTripIconIcon,
                    imageType: ImageType.svg,
                  ),

                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget yourRecentJournal(){
    return  SizedBox(
      height: 32.h,
      child: ListView.separated(
        itemCount: 3,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return  Container(
            height: 32.h,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            decoration: BoxDecoration(
              color: index== 0 ? LIGHT_GREY_COLOR3 : WHITE,
              boxShadow: [
                AppConstants().commonBoxShadow(color: GRAY_COLOR_LIGHT)
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text("${24+index}th Sep 2025",style: Styles.textFontMedium(size: 12),),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 10.w,);
        },),
    );
  }


  Widget yourRecentJournalList(){
    return SizedBox(
      height: 1.sh * 0.24,
      child: ListView.separated(
        itemCount: 3,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 1.sw * 0.42,
            padding: EdgeInsets.symmetric(horizontal: 13.w,vertical: 13.h),
            decoration: BoxDecoration(
              color: WHITE,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                AppConstants().commonBoxShadow(color: LIGHT_GREY_COLOR2)
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("Day one in my",style: Styles.textFontMedium(size: 16,),),
                SizedBox(height: 3.h,),
                Text("Lorem ipsum dolor sit amet consectetur. Enim phasellus nulla parturient ",style: Styles.textFontRegular(size: 10),),



                Spacer(),

                Container(
                  width: 1.sw,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: LIGHT_GREY_COLOR3,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(Strings.readMore,style: Styles.textFontRegular(size: 10,),),
                ),
                // SizedBox(height: 8.h,),


              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 10.w,);
        },
      ),
    );
  }

}
