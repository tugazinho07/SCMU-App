import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class UiProvider extends ChangeNotifier{

  bool _isDark = false;
  bool get isDark => _isDark;

  late SharedPreferences storage;

  final darkTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    primaryColorDark: Colors.black,
  );

  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    primaryColorDark: Colors.white,
  );

  changeTheme(){
    _isDark = !isDark;
    storage.setBool('isDark', _isDark);
    notifyListeners();
  }

  ini() async {
    storage = await SharedPreferences.getInstance();
    _isDark = storage.getBool('isDark')??false;
    notifyListeners();
  }
}