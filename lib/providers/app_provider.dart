import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/utils/utils.dart';

class AppProvider extends ChangeNotifier {
  BuildContext? _mainScreenContext;
BuildContext? get mainScreenContext => _mainScreenContext;
  void setMainScreenContext(BuildContext context) {
    _mainScreenContext = context;
  }

  int _cardCounter = 0;
  int get cardCounter => _cardCounter;
  void setcardCounter(int val) {
    _cardCounter = val;
    notifyListeners();
  }

  List<dynamic> _cards = [];
  List<dynamic> get cards => _cards;
  void setCards(List<dynamic> data) {
    if (data.length > _cards.length)
    {
      log("ShOULD NOTFY");
      rideRequestNotify();
    }
    _cards = data;
    notifyListeners();

    log("CARDS ==> ${_cards.length.toString()}");
  }
  // void addCardItem() {
  //   // _cardCounter = _cardCounter + 1;
  //   _cards.add(_cardCounter);
  //   _cardCounter++;
  //   notifyListeners();
  // }

  // void removeCardItem(int val) {
  //   log("deleted $val");
  //   _cards.remove(val);
  //   notifyListeners();
  // }

  //BOTTOM SHEET CONTROLLER
  DraggableScrollableController? _bottomSheetController;
  DraggableScrollableController? get bottomSheetController =>
      _bottomSheetController;
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
  void setFirstLaunch(bool val) async {
    _isFirstLunch = val;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', val);
    notifyListeners();
  }
}
