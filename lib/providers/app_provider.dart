import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  bool _isFirstLunch = true;

  bool get isFirstLunch => _isFirstLunch;

  void setFirstLunch(bool val) async {
    _isFirstLunch = val;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLunch', val);
    notifyListeners();
  }
}
