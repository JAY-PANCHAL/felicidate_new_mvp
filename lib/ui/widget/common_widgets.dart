import 'dart:ui';
import 'package:felicidade/common/utils/image_paths.dart';
import 'package:felicidade/ui/widget/rounded_corner_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/utils/Styles.dart';
import '../../main.dart';
import 'button_view.dart';
import 'constants/app_colors.dart';
import 'image_view.dart';



Future<void> showConfirmAlertDialog(
    String message, String positiveButtonText, String negativeButtonText,
    {Function()? positiveButtonClick,
    Function()? negativeButtonClick,
    bool? showClose, BuildContext? context}) async {
  showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context?? navigatorKey.currentContext!,
    isDismissible: false,
    enableDrag: false,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: WillPopScope(
          onWillPop: () async => true,
          child: RoundedCornerContainer(
              color:  WHITE,
              boxShadow: const [
                BoxShadow(
                    color: BLACK,
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(0, 1))
              ],
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 16),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    showClose ?? true
                        ? Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {

                                  FocusScope.of(context).unfocus();
                                  Navigator.of(context).pop();

                              },
                              child: ImageView(
                                image: AppSvgIcons.icClose,
                                imageType: ImageType.svg,
                                width: 28,
                                height: 28,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    Container(
                      padding: const EdgeInsets.only(top: 24),
                      child: Text(
                        message,
                        style: Styles.textFontRegular(size: 22),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 24, bottom: 08),
                            child: ButtonView(
                              negativeButtonText,
                              () {
                                if (negativeButtonClick == null) {
                                  FocusScope.of(context).unfocus();
                                  Navigator.of(context).pop();
                                } else {
                                  negativeButtonClick.call();
                                }
                                // Navigator.of(context).pop();
                              },
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 10.h),
                              textStyle: Styles.textFontBold(size: 16,color: WHITE),
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 24, bottom: 08),
                            child: ButtonView(
                              positiveButtonText,
                              () {
                                Navigator.of(context).pop();
                                positiveButtonClick?.call();
                              },
                              color: Colors.transparent,
                              borderColor: WHITE ,
                              borderWidth: 1.0,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 10.h),
                              textStyle: Styles.textFontBold(size: 16,color: WHITE),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 120.h,)
                  ],
                ),
              )),
        ),
      );
    },
  );
}
