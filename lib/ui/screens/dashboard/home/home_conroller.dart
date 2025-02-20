  import 'dart:async';
import 'dart:convert';

import 'package:felicidade/common/dependency_injection.dart';
import 'package:felicidade/common/utils/image_paths.dart';
import 'package:felicidade/network/model/save_feelings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../controller/base_controller.dart';
import '../../../../common/utils/Styles.dart';
import '../../../../common/utils/app_constants.dart';
import '../../../../common/utils/shared_pref_utils.dart';
import '../../../../common/utils/strings.dart';
import '../../../../network/constant/endpoints.dart';
import '../../../../network/model/journal_entries_model.dart';
import '../../../../network/model/login_model.dart';
import '../../../widget/constants/app_colors.dart';
import '../../../widget/image_view.dart';
import 'home_screen.dart';

class HomeController extends BaseController {
  var mMyDiaries = <MyDiaries>[].obs;
  List<JournalEntry> journalEntries = [];
  var selectedDate = "".obs;

  var mLoginData = Rxn<User>();


  getLoginUserData() async {
    mLoginData.value = await getUser();
    print('mLoginData.value--${mLoginData.value?.email??""}');

  }


  @override
  Future<void> onInit() async {
    var data = Get.arguments;
    journalEntries = await getLastSevenDays();
    getLoginUserData();

    if (data != null) {}
    super.onInit();
  }

  List<JournalEntry> getLastSevenDays() {
    DateTime today = DateTime.now();
    DateFormat dateFormat = DateFormat("d'th' MMM yyyy");

    return List.generate(7, (index) {
      DateTime date = today.subtract(Duration(days: index));
      return JournalEntry(
          date: dateFormat.format(date), isSelected: index == 0);
    }).reversed.toList(); // Reverse to show the oldest first
  }

  Future<void> saveFeelingsApiCall(context, String icon) async {
    isLoading.value = true;
    var mood = "";
    if (icon == AppSvgIcons.fe1Icon) {
      mood = "Awsome";
    } else if (icon == AppSvgIcons.fe2Icon) {
      mood = "Good";
    } else if (icon == AppSvgIcons.fe3Icon) {
      mood = "Neutral";
    } else if (icon == AppSvgIcons.fe4Icon) {
      mood = "Terrible";
    } else {
      mood = "Bad";
    }

    var params = {"todays_feeling": mood};

    await repo.saveFeelingsApi(params, context).then((value) async {
      isLoading.value = false;
      var data = jsonDecode(value);
      if (data != null) {
        SaveFeelingsResponse model = SaveFeelingsResponse.fromJson(data);
        if (model.status == true) {
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
        }
      }
    }, onError: (e) {
      isLoading.value = false;
      if (e.toString().contains(Strings.noInternet)) {
        AppConstants.showSnackBar(e.toString(), context, () {
          saveFeelingsApiCall(context, icon);
        });
      } else {
        AppConstants.showGetSnackBar("Hold Up!", e.toString(), RED);
      }
    });
  }

  Future<void> apiCallForGetJournalEntries(context) async {
    isLoading.value = true;

    Map<String, dynamic> params = Endpoints.getCommonParam();
    // params['journal_entry_date'] = AppConstants().getCurrentDate();
    params['journal_entry_date'] =  selectedDate.value;

    await repo.getJournalEntriesRequested(params, context).then((value) async {
      isLoading.value = false;
      var data = jsonDecode(value);
      if (data != null) {
        JournalEntriesModel model = JournalEntriesModel.fromJson(data);
        if (model.status == true) {
          mMyDiaries.value = model.data?.myDiaries ?? [];
        }
      }
    }, onError: (e) {
      isLoading.value = false;
      if (e.toString().contains(Strings.noInternet)) {
        AppConstants.showSnackBar(e.toString(), context, () {
          apiCallForGetJournalEntries(context);
        });
      } else {
        AppConstants.showGetSnackBar("Hold Up!", e.toString(), RED);
      }
    });
  }

  Future<void> feelingDialog({type = 1}) async {
    return Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 60.w),
        backgroundColor: WHITE,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Optional: Rounded corners
        ),
        child: Container(
          margin: EdgeInsets.all(5.sp),
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
              Text( type==1? Strings.hoorayShare : Strings.ConnectSomeone, textAlign: TextAlign.center,style: Styles.textFontBoldHeight(size: 18,fontFamily: AppConstants.fontFamilyOgg,color: type==1?RED_DARK:BLUE_COLOR2,height: 1.4),),
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
                      Text(Strings.noImGood, textAlign: TextAlign.center,style: Styles.textFontMedium(size: 18,color: type==1?RED_DARK:BLUE_COLOR2),),
                      SizedBox(height: 20),

                    ],
                  )),

            ],
          ),
        ),
      ),
    );
  }



}

class JournalEntry {
  String date;
  bool isSelected;

  JournalEntry({required this.date, this.isSelected = false});
}
