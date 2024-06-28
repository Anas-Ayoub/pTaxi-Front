import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingProvider extends ChangeNotifier {
  //602750296
  //688737304
  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );
  ProgressDialog? _progressDialog;

  ProgressDialog? get progressDialog => _progressDialog;

  void show(
    BuildContext context, {
    required String msg,
    ProgressType progressType = ProgressType.normal,
    bool hideValue = true,
    Color progressBgColor = Colors.grey,
    Color progressValueColor = Colors.black,
  }) {
    _progressDialog = ProgressDialog(context: context);
    _progressDialog?.show(
      msg: msg,
      progressType: progressType,
      hideValue: hideValue,
      progressBgColor: progressBgColor,
      progressValueColor: progressValueColor,
    );
    notifyListeners();
  }

  void hide() {
    _progressDialog?.close();
    _progressDialog = null;
    notifyListeners();
  }
}
