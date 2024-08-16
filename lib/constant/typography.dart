import 'package:flutter/material.dart';

const String fontFamily = 'Palanquin';

class Fonts {
  static TextStyle bold =
      const TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w700);

  static TextStyle semiBold =
      const TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w600);

  static TextStyle medium =
      const TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500);

  static TextStyle regular =
      const TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400);

  static TextStyle thin =
      const TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w300);

  static TextStyle light =
      const TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w200);

  static TextStyle extraLight =
      const TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w100);
}
