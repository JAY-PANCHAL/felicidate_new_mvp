import 'package:felicidade/common/utils/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ui/widget/constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final bool readOnly;
  final bool showCursor;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final GestureTapCallback? onTap;
  final Function(String)? validator;
  final AutovalidateMode? autovalidateMode;
  final bool autovalidate;
  final Color? cursorColor;
  final double? cursorHeight;
  final String? titleLabel;
  final LabeledGlobalKey? labelKey;

  final Function(PointerDownEvent)? onTapOutside;

  const CustomTextField({
    this.labelKey,
    this.controller,
    this.focusNode,
    this.decoration,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.showCursor = true,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.enabled,
    this.onTap,
    this.validator,
    this.autovalidateMode,
    this.autovalidate = false,
    this.cursorColor,
    this.cursorHeight,
    this.titleLabel,
    this.onTapOutside,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  Color _borderColor = BLACK; // Default border color
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _borderColor = _focusNode.hasFocus ? PRIMARY_COLOR : Colors.black;
      });
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.titleLabel != "")
          Container(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Text(
              widget.titleLabel!,
              textAlign: TextAlign.start,
              style: Styles.textFontSemiBold(size: 16),
            ),
          ),
        buildSimpleTextField(),
      ],
    );
  }

  Widget buildSimpleTextField() {
    return TextFormField(
      key: widget.labelKey,
      controller: widget.controller,
      focusNode: _focusNode,
      decoration: widget.decoration ?? InputDecoration(
        filled: true,
        fillColor: WHITE,
        focusColor: WHITE,
        contentPadding: EdgeInsets.only(left: 15,top: 10),
        errorMaxLines: 2,
        hintText: "",
        hintStyle: Styles.textFontRegular(size: 16,color: GREY_COLOR),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
              color: DIVIDER_COLOR,
              width: 1
          ),
        ),

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: DIVIDER_COLOR, // Color when focused
            width: 1,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: RED, // Color when focused
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: PRIMARY_COLOR, // Color when focused
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: DIVIDER_COLOR,
            width: 1,
          ),
        ),
      ),
      keyboardType: widget.keyboardType,
      cursorHeight: widget.cursorHeight ?? 19.h,
      onTapOutside: widget.onTapOutside,
      validator: (val) {
        final validationError = widget.validator?.call(val ?? '');
        setState(() {
          _errorText = validationError;
        });
        return validationError;
      },
      textAlignVertical: TextAlignVertical.center,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      textCapitalization: widget.textCapitalization,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      showCursor: widget.showCursor,
      obscuringCharacter: widget.obscuringCharacter,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled ?? true,
      cursorColor: widget.cursorColor ?? BLACK,
    );
  }
}