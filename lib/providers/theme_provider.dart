// lib/providers/theme_provider.dart
import 'package:book_journey/services/theme_service.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeService _themeService;
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _init();
  }

  Future<void> _init() async {
    _themeService = ThemeService();
    await _themeService.init();
    _isDarkMode = _themeService.isDarkMode;
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _themeService.toggleTheme();
    notifyListeners();
  }
}