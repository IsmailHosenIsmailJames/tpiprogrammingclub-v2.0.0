import 'package:flutter/material.dart';

class MyColorsIcons {
  static ThemeMode themeMode = ThemeMode.system;
  static const Color backgroundColorLight = Colors.white;
  static const Color backgroundColorDark = Color.fromRGBO(24, 24, 32, 1);
  static const Color gradient1 = Color.fromRGBO(187, 63, 221, 1);
  static const Color gradient2 = Color.fromRGBO(255, 65, 144, 1);
  static const Color gradient3 = Color.fromRGBO(255, 159, 124, 1);
  static const Color borderColor = Color.fromRGBO(52, 51, 67, 1);
  static const Color whiteColor = Colors.white;
  static BorderSide outlineBorder =
      const BorderSide(color: gradient2, width: 2);
  static Icon systemIcon = const Icon(
    Icons.brightness_4,
  );
  static Icon darkIcon = const Icon(
    Icons.dark_mode_outlined,
  );
  static Icon sunnyIcon = const Icon(
    Icons.wb_sunny,
  );
  static RoundedRectangleBorder textFromFieldBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  );
  static OutlineInputBorder outLinedBorderForTextFromFeild = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(width: 3),
  );
}
