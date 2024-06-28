import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String _selectedLanguage = "English";

  String get selectedLanguage => _selectedLanguage;

  void setSelectedLanguage(String language) async {
    _selectedLanguage = language;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', language);
    notifyListeners();
  }
}
