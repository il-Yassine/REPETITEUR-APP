import 'package:flutter/material.dart';

// Grey Colors
const Color kcVeryLightGreyColor = Color(0xFFF2F2F2);
const Color kcLightGreyColor = Color(0xFFe5e5e5);
const Color kcLightGray200 = Color(0xFFe5e7eb);
const Color kcGray400 = Color(0xFF9ca3af);
const Color kcGray300 = Color(0xFFd1d5db);
const Color kcMediumGreyColor = Color(0xffc4c4c4);
const Color kcDarkGreyColor = Color(0xFF868686);
const Color kcVeryDarkGreyColor = Color(0xFF5B5B5B);

const Color kcIconGrey = Colors.grey;
const Color kcDisabledColor = Colors.grey;

const Color kcLightGreenColor = Color(0xFF90EE90);
const Color kcBlackColor = Color(0xFF000000);
const Color kcWhiteColor = Color(0xFFFFFFFF);
const Color kcLinkHypertextColor = Color(0xFF4E60FF);
const Color kcErrorColor = Colors.red;
const Color kcBlueGrey = Colors.blueGrey;
const Color kcBlueGrey50 = Color(0xFFECEFF1);

// #FCD66E
const Color kcAmberColor = Color(0xFFFCD66E);

const Color kcTitleTextColor = Color(0xFF7A7A7A);

const Color kcPrimaryColor = Color(0xff592C82);
const Color kcPrimaryColor50 = Color(0x44592C82);
const Color kcAppBarColor = kcPrimaryColor;

final MaterialColor kcPrimaryMaterialColor =
    _factoryColor(kcPrimaryColor.value);

// Utils
MaterialColor hex(String hex) => _factoryColor(_getColorHexFromStr(hex));

MaterialColor _factoryColor(int color) {
  return MaterialColor(color, <int, Color>{
    50: Color(color),
    100: Color(color),
    200: Color(color),
    300: Color(color),
    400: Color(color),
    500: Color(color),
    600: Color(color),
    700: Color(color),
    800: Color(color),
    900: Color(color),
  });
}

int _getColorHexFromStr(String colorStr) {
  colorStr = "FF" + colorStr;
  colorStr = colorStr.replaceAll("#", "");
  int val = 0;
  int len = colorStr.length;
  for (int i = 0; i < len; i++) {
    int hexDigit = colorStr.codeUnitAt(i);
    if (hexDigit >= 48 && hexDigit <= 57) {
      val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 65 && hexDigit <= 70) {
// A..F
      val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 97 && hexDigit <= 102) {
// a..f
      val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
    } else {
      val = 0xFFFFFFFF;
    }
  }
  return val;
}
