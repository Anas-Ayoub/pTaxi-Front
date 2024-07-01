import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  //BOTTOM SHEET CONTROLLER
  DraggableScrollableController? _bottomSheetController;
  DraggableScrollableController? get bottomSheetController => _bottomSheetController;
  double? _maxHeight;
  double? _minHeight;
  double? get minHeight => _minHeight;
  double? get maxHeight => _maxHeight;
  void showSheet() {
    _bottomSheetController!.animateTo(
      _maxHeight!,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }
  void hideSheet() {
    _bottomSheetController!.animateTo(
      _minHeight!,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }
  void setBottomSheetController(DraggableScrollableController con) async {
    _bottomSheetController = con;
    // notifyListeners();
  }
    void setMinMaxHeight(double min, double max) async {
    _minHeight = min;
    _maxHeight = max;
    // notifyListeners();
  }

  //IS FIRST LAUNCH
  bool _isFirstLunch = true;
  bool get isFirstLunch => _isFirstLunch;
  void setFirstLunch(bool val) async {
    _isFirstLunch = val;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLunch', val);
    notifyListeners();
  }
}
