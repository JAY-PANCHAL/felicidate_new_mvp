import 'dart:async';
import 'dart:convert';

import 'package:felicidade/network/model/connect_to_feli_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../../../common/utils/Styles.dart';
import '../../../../../common/utils/app_constants.dart';
import '../../../../../common/utils/color_constants.dart';
import '../../../../../common/utils/shared_pref_utils.dart';
import '../../../../../common/utils/strings.dart';
import '../../../../../controller/base_controller.dart';
import '../../../../../network/constant/endpoints.dart';
import '../../../../../network/model/login_model.dart';
import '../../../../widget/constants/app_colors.dart';

class TalkToSomeoneController extends BaseController {
// --------------- Repository -------------

  var phoneNumber = "".obs;

  @override
  Future<void> onInit() async {
    await getLoginUserData();
    super.onInit();
  }

  var mLoginData = Rxn<User>();

  getLoginUserData() async {
    mLoginData.value = await getUser();
    print('mLoginData.value--${mLoginData.value?.id ?? ""}');
  }

  Future<void> connectToFeliApi(context) async {
    isLoading.value = true;

    Map<String, dynamic> params = Endpoints.getCommonParam();
    params['user_id'] = mLoginData.value?.id ?? 0;

    await repo.connectToFeliApi(params, context).then((value) async {
      isLoading.value = false;
      var data = jsonDecode(value);
      if (data != null) {
        ConnectToFeliModel model = ConnectToFeliModel.fromJson(data);
        if (model.status == true) {
          if (model.data?.availableUser != null) {
            if (model.data?.availableUser?.zegoCallId != "") {
              phoneNumber.value = model.data?.availableUser?.zegoCallId ?? "";
              if (phoneNumber.value != "") {
                callDialog();
              }
            }
          }
        }
      }
    }, onError: (e) {
      isLoading.value = false;
      if (e.toString().contains(Strings.noInternet)) {
        AppConstants.showSnackBar(e.toString(), context, () {
          connectToFeliApi(context);
        });
      } else {
        AppConstants.showGetSnackBar("Hold Up!", e.toString(), RED);
      }
    });
  }

  void onSendCallInvitationFinished(
    String code,
    String message,
    List<String> errorInvitees,
  ) {
    if (errorInvitees.isNotEmpty) {
      String userIDs = "";
      for (int index = 0; index < errorInvitees.length; index++) {
        if (index >= 5) {
          userIDs += '... ';
          break;
        }

        var userID = errorInvitees.elementAt(index);
        userIDs += userID + ' ';
      }
      if (userIDs.isNotEmpty) {
        userIDs = userIDs.substring(0, userIDs.length - 1);
      }

      var message = 'User doesn\'t exist or is offline: $userIDs';
      if (code.isNotEmpty) {
        message += ', code: $code, message:$message';
      }
      AppConstants.showToast(
        message,
      );
    } else if (code.isNotEmpty) {
      AppConstants.showToast(
        'code: $code, message:$message',
      );
    }
  }

  Widget sendCallButton({
    required bool isVideoCall,
    void Function(String code, String message, List<String>)? onCallFinished,
  }) {
    print("------------------------------------------------>");

    print(phoneNumber.value);

    var listInviteee = <ZegoUIKitUser>[
      ZegoUIKitUser(
        id: phoneNumber.value,
        name: 'user_${phoneNumber.value}',
      )
    ];
    return ZegoSendCallInvitationButton(
      isVideoCall: isVideoCall,
      invitees: listInviteee,
      resourceID: "zego_data",
      iconSize: const Size(50, 50),
      buttonSize: const Size(50, 50),
      onPressed: onCallFinished,
    );
  }

  callDialog() {
    Get.dialog(
      Obx(() {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Start a Call?",
                    style: Styles.textFontBold(
                        size: 22,
                        color: AppColors.black,
                        fontFamily: AppConstants.fontFamilyOgg)
                    /*  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),*/
                    ),
                const SizedBox(height: 10), // Spacing
                Text("Choose the type of call you'd like to make.",
                    textAlign: TextAlign.center,
                    style: Styles.textFontBold(
                        size: 12,
                        color: AppColors.gray1C,
                        fontFamily: AppConstants.fontFamilyOgg)

                    /*   style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                 */
                    ),
                const SizedBox(height: 20), // Spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    sendCallButton(
                      isVideoCall: false,
                      onCallFinished: onSendCallInvitationFinished,
                    ),
                    sendCallButton(
                      isVideoCall: true,
                      onCallFinished: onSendCallInvitationFinished,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
