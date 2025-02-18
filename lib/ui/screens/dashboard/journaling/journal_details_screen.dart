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
import '../../../../common/utils/app_valid.dart';
import '../../../../common/utils/strings.dart';
import '../../../widget/image_view.dart';
import 'create_story_controller.dart';
import 'journal_details_controller.dart';

class JournalDetailsScreen extends StatefulWidget {
  final int id;

  JournalDetailsScreen({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => JournalDetailsScreenState();
}

class JournalDetailsScreenState extends State<JournalDetailsScreen> {
  final DiaryDetailsController diaryDetailsController =
      Get.put(DiaryDetailsController());

  @override
  void initState() {
    super.initState();
    diaryDetailsController.apiCallForDiaryDetails(context, widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<CreateStoryController>();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Obx(() {
      return ModalProgressHUD(
          color: Colors.black.withOpacity(0.6),
          dismissible: false,
          progressIndicator: AppConstants.loader(context),
          inAsyncCall: diaryDetailsController.isLoading.value,
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
                          height: 50.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                  diaryDetailsController
                                      .diaryDetailModel.value.data?.diaryDetail?.journalTitle??
                                      "",
                                  textAlign: TextAlign.start,
                                  style: Styles.textFontMedium(
                                    fontFamily: AppConstants.fontFamilyOgg,
                                    color: AppColors.black,
                                    size: 40.sp,
                                  )),
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.back();
                              },
                              child: ImageView(
                                width: 75.sp,
                                height: 75.sp,
                                boxFit: BoxFit.contain,
                                image: AppSvgIcons.ic_down_FloatButtonIcon,
                                imageType: ImageType.svg,
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Divider(color: Color(0xFFBBBBBB),height: 2.sp,),
                        SizedBox(height:20.h,),
                        Text(
                            diaryDetailsController
                                .diaryDetailModel.value.data?.diaryDetail?.journalDescription ??
                                "",
                            textAlign: TextAlign.center,
                            maxLines: 1000,
                            style: Styles.textFontMedium(
                              fontFamily: AppConstants.fontFamilyOgg,
                              color: AppColors.black,
                              size: 24.sp,
                            )),
                      ]),
                ))),
          ));
    });
  }
}
