// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:words625/views/theme.dart';

@injectable
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  
  ThemeMode get themeMode => _themeMode;
  
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  
  ThemeData get currentTheme => VarnamalaTheme.lightTheme;
  
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    notifyListeners();
  }
  
  void setLightMode() {
    _themeMode = ThemeMode.light;
    notifyListeners();
  }
  
  void setDarkMode() {
    _themeMode = ThemeMode.dark;
    notifyListeners();
  }
}
