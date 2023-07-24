import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_colors_icons.dart';
import 'theme_storage_manager.dart';
import 'theme_provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  final int value;
  const ChangeThemeButtonWidget({super.key, required this.value});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool oneTimeTry = true;
    if (value == 1 && oneTimeTry) {
      oneTimeTry = false;
      try {
        StorageManager.readData('themeMode').then((value) {
          if (value == "system") {
            final provider = Provider.of<ThemeProvider>(context, listen: false);
            provider.toggleTheme(0);
          } else if (value == "light") {
            final provider = Provider.of<ThemeProvider>(context, listen: false);
            provider.toggleTheme(1);
          } else {
            final provider = Provider.of<ThemeProvider>(context, listen: false);
            provider.toggleTheme(-1);
          }
        });
      } catch (e) {
        print(e);
      }
    }
    return OutlinedButton.icon(
      style: ElevatedButton.styleFrom(
        side: MyColorsIcons.outlineBorder,
        minimumSize: const Size(120, 40),
        backgroundColor: Colors.black,
      ),
      onPressed: () {
        if (themeProvider.themeValue == 0) {
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          provider.toggleTheme(-1);
        } else if (themeProvider.themeValue < 0) {
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          provider.toggleTheme(1);
        } else {
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          provider.toggleTheme(0);
        }
      },
      icon: themeProvider.themeIcon,
      label: Text(
        themeProvider.themeLabel,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
