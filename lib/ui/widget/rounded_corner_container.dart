import 'package:flutter/material.dart';

import 'constants/app_colors.dart';

class RoundedCornerContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final List<BoxShadow>? boxShadow;
  final double? height;
  final double? width;
  final double? topLeftRadius;
  final double? topRightRadius;
  final double? bottomLeftRadius;
  final double? bottomRightRadius;

  const RoundedCornerContainer(
      {Key? key,
      this.child,
      this.padding,
      this.margin,
      this.color,
      this.boxShadow,
      this.height,
      this.width,
      this.topLeftRadius,
      this.topRightRadius,
      this.bottomLeftRadius,
      this.bottomRightRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding ?? const EdgeInsets.all(0),
      margin: margin ?? const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeftRadius ?? 24),
            topRight: Radius.circular(topRightRadius ?? 24),
            bottomLeft: Radius.circular(bottomLeftRadius ?? 0),
            bottomRight: Radius.circular(bottomRightRadius ?? 0)),
        color: WHITE,
        // boxShadow: boxShadow ?? [const BoxShadow()]
      ),
      child: child,
    );
  }
}
