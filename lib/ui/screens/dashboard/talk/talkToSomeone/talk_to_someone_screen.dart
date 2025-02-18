import 'package:felicidade/common/utils/color_constants.dart';
import 'package:felicidade/common/utils/image_paths.dart';
import 'package:felicidade/ui/screens/dashboard/journaling/journaling_dashboard_controller.dart';
import 'package:felicidade/ui/screens/dashboard/talk/talkToSomeone/talk_to_someone_controller.dart';
import 'package:felicidade/ui/widget/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../common/utils/Styles.dart';
import '../../../../../common/utils/app_constants.dart';
import '../../../../../common/utils/strings.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../widget/image_view.dart';


class TalkToSomeoneScreen extends StatefulWidget {
  const TalkToSomeoneScreen({super.key});

  @override
  State<StatefulWidget> createState() => TalkToSomeoneScreenState();
}

class TalkToSomeoneScreenState extends State<TalkToSomeoneScreen> {
  final TalkToSomeoneController talkToSomeoneController =
  Get.put(TalkToSomeoneController());

  @override
  void initState() {
    super.initState();
  }

  int selectedIndex = -1;

  List<Map<String, dynamic>> items = [
    {"icon": AppSvgIcons.icTs1Icon, "text": "Anxious or panicky Feeling"},
    {"icon": AppSvgIcons.icTs2Icon, "text": "Difficulty in relationship"},
    {"icon": AppSvgIcons.icTs3Icon, "text": "Traumatic Experience"},
    {"icon": AppSvgIcons.icTs4Icon, "text": "Navigating addiction"},
    {"icon": AppSvgIcons.icTs5Icon, "text": "Dealing with stress"},
    {"icon": AppSvgIcons.icTs6Icon, "text": "Don't know anything"},
  ];

  @override
  void dispose() {
    super.dispose();
    Get.delete<TalkToSomeoneController>();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Obx(() {
      return ModalProgressHUD(
          color: Colors.black.withOpacity(0.6),
          dismissible: false,
          progressIndicator: AppConstants.loader(context),
          inAsyncCall: talkToSomeoneController.isLoading.value,
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
                            image: DecorationImage(image: AssetImage(AppPngIcons.talkSomeoneBack),fit: BoxFit.cover)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 50.h,),
                              Text(Strings.selectfeelConnect,
                                  textAlign: TextAlign.center,
                                  style: Styles.textFontBoldHeight(
                                    height: 1.4,
                                    fontFamily: AppConstants.fontFamilyOgg,
                                    size: 24,
                                    color:RED_DARK)),
                              SizedBox(
                                height: 20.h,
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Note:',
                                      style: Styles.textFontMedium(size: 14).copyWith(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' that your felifriend are not expert and will\nonly listen to your problems',
                                      style: Styles.textFontRegular(size: 14).copyWith(
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 25.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: InkWell(
                                  onTap: (){

                                  },
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 45.w, vertical: 12.h),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            AppConstants().commonBoxShadow(color: LIGHT_GREY_COLOR3)
                                          ],
                                          border: Border.all(width: 1,color: Color(0xFFFFD9E2)),
                                          borderRadius: BorderRadius.circular(8),
                                          gradient: LinearGradient(
                                            colors: [
                                              WHITE,
                                              Color(0xFFFFE0E6),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          color: WHITE
                                      ),
                                      child:Text('Skip for now',style: Styles.textFontMedium(size: 16),)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.sp),
                        child: GridView.builder(
                          itemCount: items.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // 2 items per row
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1, // Adjust based on your needs
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.sp),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: selectedIndex == index ? Color(0xFFFFE8ED) : Color(0xFFEDEDED),
                                    width: selectedIndex == index ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ImageView(
                                      width: 50.sp,
                                      height: 50.sp,
                                      boxFit: BoxFit.contain,
                                      image: items[index]["icon"],
                                      imageType: ImageType.svg,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      items[index]["text"],
                                      textAlign: TextAlign.center,
                                      style: Styles.textFontBold(size: 16,color: Color(0xFF636363),fontFamily: AppConstants.fontFamilyOgg)
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      GestureDetector(
                        onTap: (){
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          margin: EdgeInsets.symmetric(horizontal: 15.w),
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
                              Text(Strings.connectWithSomoneNow,style: Styles.textFontBold(size: 17,fontFamily: AppConstants.fontFamilyOgg,color: RED_DARK),)


                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h,),
                    ])),
          ));
    });
  }
}
