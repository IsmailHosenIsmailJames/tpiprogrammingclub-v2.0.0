import 'package:flutter/material.dart';

import 'my_colors_icons.dart';
import 'theme_storage_manager.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  String themeLabel = "System";
  int themeValue = 0;
  Icon themeIcon = const Icon(
    Icons.brightness_4_outlined,
  );

  void toggleTheme(int value) {
    if (value == 0) {
      themeMode = ThemeMode.system;
      themeIcon = MyColorsIcons.systemIcon;
      themeLabel = "System";
      themeValue = 0;
      StorageManager.saveData('themeMode', 'system');
    } else if (value < 0) {
      themeMode = ThemeMode.dark;
      themeIcon = MyColorsIcons.darkIcon;
      themeLabel = "Dark";
      themeValue = -1;
      StorageManager.saveData('themeMode', 'dark');
    } else {
      themeMode = ThemeMode.light;
      themeIcon = MyColorsIcons.sunnyIcon;
      themeLabel = "Sunny";
      themeValue = 1;
      StorageManager.saveData('themeMode', 'light');
    }
    notifyListeners();
  }
}
