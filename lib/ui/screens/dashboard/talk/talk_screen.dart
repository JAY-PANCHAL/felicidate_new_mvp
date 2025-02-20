import 'package:felicidade/common/utils/image_paths.dart';
import 'package:felicidade/routes/app_pages.dart';
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
import 'talk_controller.dart';

class TalkScreen extends StatefulWidget {
  const TalkScreen({super.key});

  @override
  State<StatefulWidget> createState() => TalkScreenState();
}

class TalkScreenState extends State<TalkScreen> {
  final TalkController talkController = Get.put(TalkController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<TalkController>();
  }



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Obx(() {
      return ModalProgressHUD(
        color: Colors.black.withOpacity(0.6),
        dismissible: false,
        progressIndicator: AppConstants.loader(context),
        inAsyncCall: talkController.isLoading.value,
        child: Scaffold(
          backgroundColor: WHITE,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 1.sh * 0.55,
                  width: 1.sw,
                  margin: EdgeInsets.only(bottom: 10.h,),
                  decoration: BoxDecoration(
                    // color: Colors.green,
                    image: DecorationImage(image: AssetImage(AppPngIcons.talkBackIcon),fit: BoxFit.fitWidth)
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40.h,),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(Routes.talkToSomeoneScreen);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              boxShadow: [
                                AppConstants().commonBoxShadow(color: LIGHT_GREY_COLOR2),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ImageView(
                                  width: 30.sp,
                                  height: 30.sp,
                                  boxFit: BoxFit.contain,
                                  image: AppSvgIcons.callTalkIcon,
                                  imageType: ImageType.svg,
                                ),
                                SizedBox(width: 10.w,),
                                Text(Strings.talkToANewFeliFriend,style: Styles.textFontBold(size: 17,fontFamily: AppConstants.fontFamilyOgg,color: RED_DARK),)


                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Text(Strings.recentlyTalkedWith,style: Styles.textFontMedium(size: 20,)),
                        SizedBox(height: 12.h,),
                        recentlyTalkedWith(),
                  
                  
                  
                      ],
                    ),
                  ),
                ),

                yourFavouriteWidget(),
                SizedBox(height: 30.h,),
                needExpertWidget(),


                SizedBox(height: 70.h,),

              ],
            ),
          ),
        ),
      );
    });
  }

  Widget recentlyTalkedWith(){
    return SizedBox(
      height: 1.sh * 0.335,
      child: ListView.separated(
        itemCount: 3,
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 5.h),
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
                        AppConstants().commonBoxShadow(color: LIGHT_GREY_COLOR3)
                      ],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: HOME_RED_LIGHT,width: 0.5)
                  ),
                  child: Text(Strings.feliFriend,style: Styles.textFontBold(size: 12,color:HOME_RED_LIGHT  ),),
                ),
                SizedBox(height: 8.h,),
                Text("Rohit Kadam",style: Styles.textFontMedium(size: 19,color:RED_DARK  ),),


                Text("24th Sep 2024  12:00 Min",style: Styles.textFontMedium(size: 12,color:RED_DARK  ),),

                SizedBox(height: 45.h,),

                Container(
                  width: 1.sw,
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: HOME_RED_LIGHT2,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(Strings.callNow,style: Styles.textFontRegular(size: 12,color: RED_DARK  ),),
                ),
                SizedBox(height: 8.h,),
                Container(
                  width: 1.sw,
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: WHITE,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: RED_DARK,width: 0.5)
                  ),
                  child: Text(Strings.addtofav,style: Styles.textFontRegular(size: 12,color:RED_DARK  ),),
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

  Widget yourFavouriteWidget(){
    final List<Map<String, String>> users = [
      {'name': 'Rohit Kadam', 'initial': 'R'},
      {'name': 'Aryasheel Jadhav', 'initial': 'A'},
      {'name': 'Aayushi Joshi', 'initial': 'A'},
      {'name': 'Atharv Raut', 'initial': 'A'},
      {'name': 'Rohit Kadam', 'initial': 'R'},
      {'name': 'Aryasheel Jadhav', 'initial': 'A'},
      {'name': 'Aayushi Joshi', 'initial': 'A'},
      {'name': 'Atharv Raut', 'initial': 'A'},
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h,),
          Text(Strings.yourFavourite,style: Styles.textFontMedium(size: 20,)),
          SizedBox(height: 20.h,),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Number of columns
              mainAxisSpacing: 8.h, // Vertical spacing
              crossAxisSpacing: 5, // Horizontal spacing
              childAspectRatio: 0.7
            ),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: WHITE,
                      shape: BoxShape.circle,
                      boxShadow: [
                        AppConstants().commonBoxShadow()
                      ]
                    ),
                    child: Text(
                      user['initial']!,
                      style: Styles.textFontBold(size: 28,color: RED_DARK)
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  Text(
                    user['name']!,
                    style: Styles.textFontMedium(size: 14,color: GREY_COLOR),textAlign: TextAlign.center,),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget needExpertWidget(){
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 1.sw,
          margin: EdgeInsets.symmetric(horizontal: 15.w),
          padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 18.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              AppConstants().commonBoxShadow()
            ],
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFFDCF7FF),
                Color(0xFFE2F8FF),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Need expert advice\non a serious topic?",style: Styles.textFontMedium(size: 20,color: HOME_BLUE_COLOR),),
              SizedBox(height: 12.h,),
              Text("We’ve certified doctors and\nprofessionals to help you out.",style: Styles.textFontRegular(size: 12),),
              SizedBox(height: 20.h,),

              Container(
                width: 1.sw * 0.45,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  boxShadow: [
                    AppConstants().commonBoxShadow(),
                  ],
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF0BA2D2),
                      Color(0xFF7ADFFF),
                    ],
                  ),
                ),
                child: Text(Strings.talkWithOurExperts,style: Styles.textFontMedium(size: 12,color: WHITE),),
              ),


            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: ImageView(
            width: 120.w,
            height: 150.h,
            boxFit: BoxFit.contain,
            image: AppPngIcons.manImage,
            imageType: ImageType.asset,
          ),
        ),
      ],
    );
  }

}
