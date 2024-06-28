import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LanguageProvider extends ChangeNotifier {

  String _selectedLanguageCode = "fr";
  String get selectedLanguage => _selectedLanguageCode;

  void setSelectedLanguage(String code) async {
    _selectedLanguageCode = code;
    notifyListeners();
  }

  // Future<String> getSelectedLanguage() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _selectedLanguageCode = prefs.getString('selectedLanguage') ?? 'ar';
  //   return _selectedLanguageCode;
  // }

  Future<void> loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _selectedLanguageCode = prefs.getString('selectedLanguage') ?? 'ar';
  }
}
