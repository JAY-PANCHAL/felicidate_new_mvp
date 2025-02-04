// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const Color PRIMARY_COLOR = Color(0xFFFFA9BC);
const Color BLUE_COLOR = Color(0xFF0170A3);
const Color LIGHT_BLUE1= Color(0xFFE7F7FF);
const Color LIGHT_BLUE2 = Color(0xFFA8E2FF);
const Color DARK_GREY = Color(0xFF6F6F6F);
const Color BLACK_COLOR2 = Color(0xFF2A2A2A);
const Color GRAY_COLOR_LIGHT = Color(0xFFD5DEE2);
const Color PRIMARY_COLOR_GRA1 =  Color(0xFFFFC7D3);
const Color PRIMARY_COLOR_GRA2 = Color(0xFFFFE8ED);
const Color PRIMARY_COLOR_GRA3 = Color(0xFFFDEEF3);
const Color RED_DARK = Color(0xFFBD0730);


const Color LIGHT_BLACK = Color(0xFF2C3125);
const Color OFF_WHITE = Color(0xFFF9FAF8);
const Color ROSE_TAUPE_COLOR = Color(0xFF965454);
const Color RED_COLOR = Color(0xFFE46B62);
const Color DETAILS_COLOR = Color(0xFF61DEA9);
const Color BLUE_COLOR2 = Color(0xFF00B3FF);
const Color LIGHT_GREEN = Color(0xFFF2F5EF);
const Color DIVIDER_COLOR = Color(0xFFC1C7BC);
const Color DIVIDER_COLOR2 = Color(0xFFDADADA);
const Color LIGHT_GREY_COLOR = Color(0xffF7F9FA);

const Color LIGHT_GREY_COLOR2 = Color(0xffd2d9dc);


const Color ACCENT_COLOR = Color(0xFF84C043);
const Color BUTTON_COLOR = Color(0xFF84C043);
const Color GREEN_COLOR = Color(0xFF96CC5B);
const Color GREEN_COLOR2 = Color(0xFFA3CE73);
const Color YELLOW_COLOR = Color(0xFFFEBB34);
Color HINT_TEXT_COLOR = HexColor.fromHex("#A1B0B1");
const Color FILL_GREY_COLOR = Color(0xFFF5F5F5);
const Color GREY_COLOR = Color(0xFF807B7B);

const Color WHITE = Colors.white;
const Color BLACK = Colors.black;
const Color RED = Colors.red;
const Color PINK = Color(0xFFFC456F);
const Color PINK_LIGHT = Color(0xFFEA5686);
const Color LIGHT_GREY = Color(0xFFEEEEEE);
const Color BACK_BUTTON_ACCENT_COLOR = Color(0xFF131A0A);

const SubscribeBtnCollor = Color(0xFFD34848);

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
