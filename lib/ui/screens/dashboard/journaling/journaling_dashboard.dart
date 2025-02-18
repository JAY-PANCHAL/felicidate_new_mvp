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
import 'journal_details_screen.dart';

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
    jdController.apiCallForGetJournalEntries(context);
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
            body: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 1.sw,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(AppPngIcons.createNewStoryBack),fit: BoxFit.cover)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 50.h,),
                            Text(Strings.forAddingYourMoments,
                                textAlign: TextAlign.center,
                                style: Styles.textFontMedium(
                                  fontFamily: AppConstants.fontFamilyOgg,
                                  size: 32,
                                ).copyWith(fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: InkWell(
                                onTap: (){
                                  Get.toNamed(Routes.createNewStoryScreen)?.then((val){
                                    if(val=='update'){
                                      jdController.apiCallForGetJournalEntries(context);
                                    }
                                  });
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 15.h),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        AppConstants().commonBoxShadow(color: LIGHT_GREY_COLOR2)
                                      ],
                                      border: Border.all(width: 0.5,color: Color(0xFFD6D6D6)),
                                      borderRadius: BorderRadius.circular(8),
                                      color: WHITE
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
                                          width: 13.h,
                                        ),
                                        Text(Strings.createAnewStory,
                                            style: Styles.textFontBold(
                                              fontFamily: AppConstants.fontFamilyOgg,
                                              size: 18,
                                            )),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),


                      SizedBox(height: 20.h,),

                      Container(
                        height: 1.sh * 0.42,
                        alignment: Alignment.centerLeft,
                        child: ListView.separated(itemCount: jdController.mMyDiaries.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                          var data = jdController.mMyDiaries[index];
                          return GestureDetector(
                            onTap: (){
                              Get.to(JournalDetailsScreen(
                                  id: jdController.mMyDiaries.value[index].id ?? 0));

                            },
                            child: Container(
                              height: 1.sh * 0.4,
                              width: 1.sw * 0.58,
                              padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 15.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  AppConstants().commonBoxShadow(color: LIGHT_GREY_COLOR2)
                                ],
                                gradient:
                                index%2==0?
                                LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    WHITE,
                                    Color(0xFFF3F3F3),
                                  ],
                                ):LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [

                                    Color(0xFFE0F8FF),
                                    WHITE,
                                  ],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppConstants().formatDateTimeString(data.createdAt??""),style: Styles.textFontBold(size: 12,color:  index%2==0?BLACK:HOME_BLUE_COLOR),),
                                  Spacer(),
                                  Text(data.journalDescription??"",style: Styles.textFontBoldHeight(size: 32,fontFamily: AppConstants.fontFamilyOgg,color: index%2==0?BLACK:HOME_BLUE_COLOR),),
                                  SizedBox(height: 10.h,),
                                  Text("${Strings.anxious} • ${data.journalTitle??""}",style: Styles.textFontBoldHeight(size: 12,color: index%2==0?BLACK:HOME_BLUE_COLOR),),
                                  SizedBox(height: 3.h,),

                                ],
                              ),
                            ),
                          );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: 15.w,);
                          },),
                      ),
                      SizedBox(height: 25.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 20.h),
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFFF8F8F8),
                            border: Border.all(color: Color(0xFFD5D5D5),width: 0.5)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(Strings.feelingsLongText,
                                  textAlign: TextAlign.center,
                                  style: Styles.textFontRegular(
                                    size: 16,
                                  ).copyWith(fontStyle: FontStyle.italic)),
                            ],
                          ),
                        ),
                      )
                    ])),
          ));
    });
  }
}
