import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/utils/Styles.dart';
import 'constants/app_colors.dart';


class ButtonView extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final Color? disableColor;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  final double radius;
  final bool disable;
  final AlignmentGeometry alignment;
  final Widget? postfix;
  final double height;
  final double minWidth;
  final TextStyle? textStyle;
  final VoidCallback? isForceClick;
  final double? borderWidth;
  final Color? borderColor;
  final double? elevation;
  final Widget? child;
  final Decoration? decoration;
  final bool? isGradient;

  const ButtonView(
    this.text,
    this.onPressed, {
    super.key,
    this.color,
    this.textColor,
    this.disableColor,
    this.height = 0,
    this.minWidth = double.infinity,
    this.radius = 15,
    this.textStyle,
    this.disable = false,
    this.borderColor,
    this.borderWidth,
    this.alignment = Alignment.center,
    this.postfix,
    this.isForceClick,
    this.padding /* = const EdgeInsets.all(16)*/,
    this.elevation,
    this.child,
    this.decoration,
    this.isGradient = true,
    shape,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Rounded corners
        ),
        // Text color
        elevation: 0, // No shadow
      ),
      child: Container(
        decoration: BoxDecoration(
         color: PRIMARY_COLOR,
          borderRadius: BorderRadius.circular(15.0), // Rounded corners
        ),
        padding: (padding == null)
            ? EdgeInsets.symmetric(vertical: 11.0.h)
            : padding,
        child: Row(
          children: [
            Expanded(
              child: Align(
                  alignment: alignment,
                  child: child ??
                      Text(
                        text,
                        maxLines: 1,
                        style: Styles.textFontSemiBold(size: 16,color: WHITE),
                        textAlign: TextAlign.center,
                      )),
            ),
            postfix == null
                ? const SizedBox()
                : Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: postfix,
                  )
          ],
        ),
      ),
    );
  }
}
