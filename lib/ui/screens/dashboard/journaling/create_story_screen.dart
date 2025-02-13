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
import '../../../widget/image_view.dart';

class CreateNewStoryScreen extends StatefulWidget {
  const CreateNewStoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => CreateNewStoryScreenState();
}

class CreateNewStoryScreenState extends State<CreateNewStoryScreen> {
  final JournalingDashboardController jdController =
  Get.put(JournalingDashboardController());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController summaryController = TextEditingController();

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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 50.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(Strings.createJournalEntry,
                                    textAlign: TextAlign.center,
                                    style: Styles.textFontMedium(
                                      fontFamily: AppConstants.fontFamilyOgg,
                                      size: 22,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            Text("Title for your thought",
                                style: Styles.textFontMedium(
                                  fontFamily: AppConstants.fontFamilyOgg,
                                  size: 12,
                                )),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: titleController,
                              decoration: InputDecoration(
                                hintText: "Enter title",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Text("Write your thoughts here (summary)",
                                style: Styles.textFontMedium(
                                  fontFamily: AppConstants.fontFamilyOgg,
                                  size: 12,
                                )),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: summaryController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                hintText: "Write your thoughts...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            SizedBox(height: 50.h),
                            AppConstants.CommonButtom(
                                text: Strings.txtContinue, onTap: () {})
                          ]),
                    ))),
          ));
    });
  }
}
