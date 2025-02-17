import 'package:felicidade/common/utils/image_paths.dart';
import 'package:felicidade/ui/screens/dashboard/journaling/journal_details_screen.dart';
import 'package:felicidade/ui/widget/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../common/utils/app_constants.dart';
import '../../../../common/utils/Styles.dart';
import '../../../../common/utils/strings.dart';
import '../../../../routes/app_pages.dart';
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
    homeController.apiCallForGetJournalEntries(context);
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
                    SizedBox(
                      height: 40.h,
                    ),
                    Text("Hello ${homeController.mLoginData.value?.name??''}",
                        style: Styles.textFontBold(
                          size: 26,
                          fontFamily: AppConstants.fontFamilyOgg,
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                    feelingWidget(),
                    SizedBox(
                      height: 20.h,
                    ),
                    feturesWidget(),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(Strings.recentlyTalkedWith,
                        style: Styles.textFontMedium(
                          size: 16,
                        )),
                    SizedBox(
                      height: 10.h,
                    ),
                    recentlyTalkedWith(),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(Strings.yourRecentJournalEntries,
                        style: Styles.textFontMedium(
                          size: 16,
                        )),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(Strings.findExpertsToTalk,
                        style: Styles.textFontRegular(
                          size: 10,
                        )),
                    SizedBox(
                      height: 10.h,
                    ),
                    yourRecentJournal(),
                    SizedBox(
                      height: 10.h,
                    ),
                    yourRecentJournalList(),
                    SizedBox(
                      height: 80.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget feelingWidget() {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: WHITE,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [AppConstants().commonBoxShadow()],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Strings.howAreYouFeeling,
              style: Styles.textFontBold(
                size: 14,
              )),
          SizedBox(
            height: 10.h,
          ),
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

  Widget commonFeeling({String? icon}) {
    return GestureDetector(
      onTap: () {
        // homeController.saveFeelingsApiCall(context, icon ?? "");
        if (icon == AppSvgIcons.fe1Icon) {
          feelingDialog();
        } else if (icon == AppSvgIcons.fe2Icon) {
          feelingDialog();
        } else if (icon == AppSvgIcons.fe3Icon) {
          feelingDialog();
        } else if (icon == AppSvgIcons.fe4Icon) {
          feelingDialog(type: 2);
        } else {
          feelingDialog(type: 2);
        }
      },
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          AppConstants().commonBoxShadow(blurRadius: 5, color: DIVIDER_COLOR2)
        ]),
        child: ImageView(
          width: 55.sp,
          height: 55.sp,
          boxFit: BoxFit.contain,
          image: icon ?? AppSvgIcons.fe1Icon,
          imageType: ImageType.svg,
        ),
      ),
    );
  }

  Widget recentlyTalkedWith() {
    return SizedBox(
      height: 1.sh * 0.316,
      child: ListView.separated(
        itemCount: 3,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 1.sw * 0.42,
            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 13.h),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                      color: WHITE,
                      boxShadow: [AppConstants().commonBoxShadow()],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: HOME_RED_LIGHT, width: 0.5)),
                  child: Text(
                    Strings.feliFriend,
                    style: Styles.textFontBold(size: 10, color: HOME_RED_LIGHT),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "Rohit Kadam",
                  style: Styles.textFontMedium(size: 17, color: RED_DARK),
                ),
                // SizedBox(height: 10.h,),
                Text(
                  "Lorem ipsum dolor sit amet consectetur. Magnis id.",
                  style: Styles.textFontRegular(size: 10),
                ),
                SizedBox(
                  height: 5.h,
                ),

                Text(
                  "24th Sep 2024  12:00 Min",
                  style: Styles.textFontMedium(size: 10, color: RED_DARK),
                ),

                SizedBox(
                  height: 25.h,
                ),

                Container(
                  width: 1.sw,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: HOME_RED_LIGHT2,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    Strings.callNow,
                    style: Styles.textFontRegular(size: 10, color: RED_DARK),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  width: 1.sw,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: WHITE,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: RED_DARK, width: 0.5)),
                  child: Text(
                    Strings.feliFriend,
                    style: Styles.textFontRegular(size: 10, color: RED_DARK),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 10.w,
          );
        },
      ),
    );
  }

  Future<void> feelingDialog({type = 1}) async {
    return Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 70.w),
        backgroundColor: WHITE,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Optional: Rounded corners
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Prevents unnecessary expansion
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 35),
            ImageView(
              width: 80.sp, // Decreased icon size
              height: 80.sp,
              boxFit: BoxFit.contain,
              image: type==1? AppSvgIcons.icHorrayIcon:AppSvgIcons.icConnectSomeoneIcon,
              imageType: ImageType.svg,
            ),
            SizedBox(height: 20),
            Text( type==1? Strings.hoorayShare : Strings.ConnectSomeone, textAlign: TextAlign.center,style: Styles.textFontBoldHeight(size: 19,fontFamily: AppConstants.fontFamilyOgg,color: type==1?RED_DARK:BLUE_COLOR2,height: 1.4),),
            SizedBox(height: 7.h,),
            type==1?
            AppConstants.CommonButtom2(
                text: Strings.startCallingPeople,
                onTap: (){


                }
            ):    AppConstants.CommonButtom3(
                text: Strings.connectWithSomone,
                onTap: (){


                }
            ),
            SizedBox(height: 7),
            GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 7),
                    Text(Strings.noImGood, textAlign: TextAlign.center,style: Styles.textFontMedium(size: 17,color: type==1?RED_DARK:BLUE_COLOR2),),
                    SizedBox(height: 20),

                  ],
                )),

          ],
        ),
      ),
    );
  }

  Widget feturesWidget() {
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
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      decoration: BoxDecoration(
                          color: WHITE,
                          boxShadow: [AppConstants().commonBoxShadow()],
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: HOME_RED_LIGHT, width: 0.5)),
                      child: Text(
                        Strings.itFree,
                        style: Styles.textFontBold(
                            size: 10, color: HOME_RED_LIGHT),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    Strings.talkWithSomeone,
                    style: Styles.textFontBoldHeight(
                        size: 18,
                        color: RED_DARK,
                        fontFamily: AppConstants.fontFamilyOgg),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
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
            SizedBox(
              height: 12.h,
            ),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.journalingDashboard);
              },
              child: Container(
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
                    SizedBox(
                      height: 10.h,
                    ),
                    ImageView(
                      width: 90.sp,
                      height: 90.sp,
                      boxFit: BoxFit.contain,
                      image: AppSvgIcons.writeYourIcon,
                      imageType: ImageType.svg,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      Strings.writeYourThoughtsDown,
                      style: Styles.textFontBoldHeight(
                          size: 18,
                          color: BLACK_COLOR3,
                          fontFamily: AppConstants.fontFamilyOgg),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
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
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      decoration: BoxDecoration(
                          color: WHITE,
                          boxShadow: [AppConstants().commonBoxShadow()],
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: BLUE_COLOR3, width: 0.5)),
                      child: Text(
                        Strings.comingSoon,
                        style:
                            Styles.textFontBold(size: 10, color: BLUE_COLOR3),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  ImageView(
                    width: 65.sp,
                    height: 65.sp,
                    boxFit: BoxFit.contain,
                    image: AppSvgIcons.bookCallIcon,
                    imageType: ImageType.svg,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    Strings.bookCallWithExperts,
                    style: Styles.textFontBoldHeight(
                        size: 18,
                        color: BLUE_COLOR3,
                        fontFamily: AppConstants.fontFamilyOgg),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
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
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    decoration: BoxDecoration(
                        color: WHITE,
                        boxShadow: [AppConstants().commonBoxShadow()],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: YELLOW_COLOR, width: 0.5)),
                    child: Text(
                      Strings.comingSoon,
                      style: Styles.textFontBold(size: 10, color: YELLOW_COLOR),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    Strings.startFreakingYourTrip,
                    style: Styles.textFontBoldHeight(
                        size: 18,
                        color: YELLOW_COLOR,
                        fontFamily: AppConstants.fontFamilyOgg),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
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

/*
  Widget yourRecentJournal() {
    return SizedBox(
      height: 32.h,
      child: ListView.separated(
        itemCount: 3,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 32.h,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            decoration: BoxDecoration(
              color: index == 0 ? LIGHT_GREY_COLOR3 : WHITE,
              boxShadow: [
                AppConstants().commonBoxShadow(color: GRAY_COLOR_LIGHT)
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "${24 + index}th Sep 2025",
              style: Styles.textFontMedium(size: 12),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 10.w,
          );
        },
      ),
    );
  }
*/
  Widget yourRecentJournal() {
    List<String> lastSevenDays = getLastSevenDays();

    return /*SizedBox(
      height: 32.h,
      child: ListView.separated(
        itemCount: lastSevenDays.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 32.h,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            decoration: BoxDecoration(
              color: index == 0 ? LIGHT_GREY_COLOR3 : WHITE,
              boxShadow: [
                AppConstants().commonBoxShadow(color: GRAY_COLOR_LIGHT)
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              lastSevenDays[index],
              style: Styles.textFontMedium(size: 12),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 10.w,
          );
        },
      ),
    )*/
        SizedBox(
      height: 32.h,
      child: ListView.separated(
        itemCount: homeController.journalEntries.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () async {
              for (var entry in homeController.journalEntries) {
                entry.isSelected = false;
              }
              homeController.journalEntries[index].isSelected = true;
              homeController.selectedDate.value =
                  homeController.journalEntries[index].date;
              await homeController.apiCallForGetJournalEntries(context);
            },
            child: Container(
              height: 32.h,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                color: homeController.journalEntries[index].isSelected
                    ? LIGHT_GREY_COLOR3
                    : WHITE,
                boxShadow: [
                  AppConstants().commonBoxShadow(color: GRAY_COLOR_LIGHT)
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                homeController.journalEntries[index].date,
                style: Styles.textFontMedium(size: 12),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 10.w);
        },
      ),
    );
    ;
  }

  List<String> getLastSevenDays() {
    DateTime today = DateTime.now();
    DateFormat dateFormat = DateFormat("d'th' MMM yyyy");

    return List.generate(7, (index) {
      DateTime date = today.subtract(Duration(days: index));
      return dateFormat.format(date);
    }).reversed.toList(); // Reverse to show the oldest first
  }

  Widget yourRecentJournalList() {
    return SizedBox(
      height: 1.sh * 0.24,
      child: ListView.separated(
        itemCount: homeController.mMyDiaries.value.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int i) {
          return Container(
            width: 1.sw * 0.42,
            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 13.h),
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
                Text(
                  homeController.mMyDiaries.value[i].journalTitle ?? "",
                  style: Styles.textFontMedium(
                    size: 16,
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  homeController.mMyDiaries.value[i].journalDescription ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.textFontRegular(size: 10),
                ),

                Spacer(),

                GestureDetector(
                  onTap: () {
                    Get.to(JournalDetailsScreen(
                        id: homeController.mMyDiaries.value[i].id ?? 0));
                  },
                  child: Container(
                    width: 1.sw,
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: LIGHT_GREY_COLOR3,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      Strings.readMore,
                      style: Styles.textFontRegular(
                        size: 10,
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 8.h,),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 10.w,
          );
        },
      ),
    );
  }






}
