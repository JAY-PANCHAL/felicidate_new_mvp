import 'dart:io';

// import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import 'constants/app_colors.dart';

enum ImageType { asset, file, network, svg, networkSvg }

enum ImageShape { circle, rectangle, oval, none }

class ImageView extends StatelessWidget {
  /// image type is for provide different image loader with enum type
  /// it provide image changes as asset, file, network, or cached
  final ImageType imageType;

  /// image shape is for define the shape around the image
  /// as provided circle , rounded or none
  final ImageShape imageShape;

  /// image path is the path of the image that will be loaded from
  final String image;

  /// color for change tint image with different color, by default it's null
  final Color? color, defaultLoaderColor, defaultErrorBuilderColor;

  /// image height and width , by default is null
  final double? height, width;

  /// change image fit into source, default is null
  final BoxFit? boxFit;

  /// error and loader Builders have default value in case of null
  final Widget? errorBuilder, loaderBuilder;

  /// How to align the image within its bounds.
  ///
  /// The alignment aligns the given position in the image to the given position
  /// in the layout bounds. For example, an [Alignment] alignment of (-1.0,
  /// -1.0) aligns the image to the top-left corner of its layout bounds, while an
  /// [Alignment] alignment of (1.0, 1.0) aligns the bottom right of the
  /// image with the bottom right corner of its layout bounds. Similarly, an
  /// alignment of (0.0, 1.0) aligns the bottom middle of the image with the
  /// middle of the bottom edge of its layout bounds.
  ///
  /// To display a subpart of an image, consider using a [CustomPainter] and
  /// [Canvas.drawImageRect].
  ///
  /// If the [alignment] is [TextDirection]-dependent (i.e. if it is a
  /// [AlignmentDirectional]), then an ambient [Directionality] widget
  /// must be in scope.
  ///
  /// Defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final Alignment alignment;

  /// image scale , default value is 1.0
  final double scale;

  /// work only when [ImageShape.rectangle]
  /// If non-null, the corners of this box are rounded by this [BorderRadius].
  ///
  /// Applies only to boxes with rectangular shapes; ignored if [shape] is not
  /// [BoxShape.rectangle].
  ///
  /// {@macro flutter.painting.BoxDecoration.clip}
  final BorderRadiusGeometry? borderRadius;

  const ImageView(
      {super.key,
      required this.image,
      required this.imageType,
      this.imageShape = ImageShape.none,
      this.color,
      this.height,
      this.width,
      this.boxFit,
      this.errorBuilder,
      this.loaderBuilder,
      this.alignment = Alignment.center,
      this.scale = 1.0,
      this.borderRadius,
      this.defaultLoaderColor,
      this.defaultErrorBuilderColor});


  @override
  Widget build(BuildContext context) {
    //var imageEnv = environment == 'DEV' ? _loadImageUat : _loadImageProd;
    switch (imageShape) {
      case ImageShape.circle:
        return _circle;
      case ImageShape.rectangle:
        return _rounded;
      case ImageShape.none:
        return /*environment == 'DEV' ? _loadImageUat :*/ _loadImageUat;
      case ImageShape.oval:
        return _oval;
    }
  }

  Widget get _rounded => Container(
        child: /*environment == 'DEV' ? _loadImageUat :*/ _loadImageUat,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: borderRadius),
      );

  Widget get _circle => Container(
        child: /*environment == 'DEV' ? _loadImageUat : */ _loadImageUat,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(shape: BoxShape.circle),
      );

  Widget get _oval => ClipOval(
        child: /*environment == 'DEV' ? _loadImageUat :*/ _loadImageUat,
        clipBehavior: Clip.antiAlias,
      );

  Widget get _loadImageProd {
    switch (imageType) {
      case ImageType.asset:
        return _cached;
      case ImageType.file:
        return _cached;
      case ImageType.network:
        return _cached;
      case ImageType.svg:
        return _svgNetworkIcon;
      case ImageType.networkSvg:
        return _svgNetworkIcon;
    }
  }

  Widget get _loadImageUat {
    switch (imageType) {
      case ImageType.asset:
        return _asset;
      case ImageType.file:
        return _file;
      case ImageType.network:
        return _cached;
      case ImageType.svg:
        return _svgLocalIcon;
      case ImageType.networkSvg:
        return _svgNetworkIcon;
    }
  }

  Widget get _svgLocalIcon => SvgPicture.asset(
        image,
        height: height,
        width: width,
        color: color,
        fit: boxFit == null ? BoxFit.contain : boxFit!,
        alignment: alignment,
        placeholderBuilder: (context) => _errorBuilder,
      );

  Widget get _svgNetworkIcon => SvgPicture.network(
        image,
        height: height,
        width: width,
        color: color,
        fit: boxFit == null ? BoxFit.contain : boxFit!,
        alignment: alignment,
        placeholderBuilder: (context) => _loaderBuilder,
      );

  Widget get _file => Image.file(File(image),
      color: color,
      cacheHeight: height!.toInt(),
      cacheWidth: width!.toInt(),
      height: height,
      width: width,
      fit: boxFit,
      errorBuilder: (context, error, stackTrace) => _errorBuilder,
      alignment: alignment,
      scale: scale);

  Widget get _cached {
    //print(image);
    /*

    */
    //   return CachedNetworkImage(
    //     imageUrl: image,
    //     color: color,
    //     height: height,
    //     width: width,
    //     fit: boxFit,
    //     progressIndicatorBuilder: (context, url, progress) => Container(
    //       height: height,
    //       width: width,
    //       color: Colors.transparent,
    //       child: Padding(
    //         padding: EdgeInsets.all(10.0),
    //         // child: CircularProgressIndicator(
    //         //   color: PRIMARY_COLOR,
    //         //   strokeWidth: 1,
    //         // ),
    //       ),
    //     ),
    //     errorWidget: (context, url, error) => Container(
    //         height: height,
    //         width: width,
    //         child: Center(child: Icon(Icons.error))),
    //     alignment: alignment,
    //   );
    // }

    var newpath = image.replaceAll(" ", "%20");
    var url = Uri.parse(newpath);

    if (image.contains('http') == false) {
      return _asset;
    }
    String fileExtenction = url.path.split("/").last.split(".").last;
    if (fileExtenction == "svg") {
      return _svgNetworkIcon;
    }

    // print(newpath.);
    return ExtendedImage.network(
      newpath,
      cacheMaxAge: const Duration(hours: 24),
      enableLoadState: true,
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return SizedBox(
              height: height,
              width: width,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0.w)),
                  child: Container(
                    color: WHITE,
                  ),
                ),
              ),
              // color: Colors.transparent,
            );
          case LoadState.completed:
            return ExtendedRawImage(
              image: state.extendedImageInfo?.image,
              height: height,
              width: width,
              fit: boxFit,
              alignment: alignment,
              color: color,
              scale: scale,
            );
          case LoadState.failed:
            return SizedBox(
                height: height, width: width /*, child: Icon(Icons.error)*/);
        }
      },
      height: height,
      width: width,
      fit: boxFit,
      cache: true,
      clearMemoryCacheWhenDispose: false,
      border: Border.all(color: Colors.transparent, width: 0.0),
      // shape: boxShape,
      // borderRadius: BorderRadius.all(Radius.circular(30.0)),
      //cancelToken: cancellationToken,
    );
  }

  Widget get _asset {
    if (image.contains('http') == true) {
      return _cached;
    }
    return Image.asset(
      image,
      alignment: alignment,
      fit: boxFit,
      width: width,
      height: height,
      color: color,
      scale: scale,
      errorBuilder: (context, error, stackTrace) => _errorBuilder,
    );
  }

  Widget get _loaderBuilder => Container(
        width: width,
        height: height,
        color: LIGHT_GREY,
        child: Center(
          child: _loader,
        ),
      );

  Widget get _errorBuilder =>
      errorBuilder == null ? _defaultErrorBuilder : errorBuilder!;

  Widget get _defaultErrorBuilder => Container(
        width: width,
        height: height,
        color: LIGHT_GREY,
      );

/*  Widget get _loader => loaderBuilder == null
      ? CircularProgressIndicator(
    color: defaultLoaderColor,
    backgroundColor: Colors.transparent,
  ) : loaderBuilder!;*/

  Widget get _loader => loaderBuilder == null
      ? Container(
          color: defaultLoaderColor,
        )
      : loaderBuilder!;
}
