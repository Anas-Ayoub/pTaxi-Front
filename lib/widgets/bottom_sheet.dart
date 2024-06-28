import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taxi_app/services/authentication_service.dart';
import 'package:taxi_app/route_names.dart';

class DraggableBottomSheet extends StatefulWidget {
  const DraggableBottomSheet({super.key});

  @override
  State<DraggableBottomSheet> createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  late DraggableScrollableController _bottomSheetController;
  final double _minHeight = 0.04;
  final double _maxHeight = 1;
  final double _initHeight = 0.3;

  @override
  void initState() {
    super.initState();

    _bottomSheetController = DraggableScrollableController();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _bottomSheetController,

      snap: true,
      snapSizes: [_initHeight],
      initialChildSize: _initHeight,
      minChildSize: _minHeight,
      maxChildSize: _maxHeight,
      builder: (_, controller) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        child: Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          color: const Color.fromARGB(255, 43, 44, 44),
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    _bottomSheetController.animateTo(_initHeight,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut);
                  },
                  onDoubleTap: () {
                    _bottomSheetController.animateTo(_maxHeight,
                        duration: const Duration(milliseconds: 450),
                        curve: Curves.easeInOutCubic);
                  },
                  child: SizedBox(
                    width: double.infinity,
                    height: 25,
                    // decoration:
                    //     BoxDecoration(border: Border.all(width: 3)),
                    child: Center(
                      child: Container(
                        width: 75,
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(133, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => AuthService().signOutGoogle(),
                  child: Text("LogOut"),
                ),
                TextButton(
                  onPressed: () => context.pushNamed(RouteNames.profile),
                  child: Text("PROFIL"),
                ),
                TextButton(
                  onPressed: () async {
                    // final FirebaseFirestore _firestore =
                    //     FirebaseFirestore.instance;

                    // await _firestore.collection('reqq').add({
                    //   'passengerId': 1,
                    //   'name': "anas",
                    // });
                  },
                  child: Text("SEND NOTIF"),
                ),
              ],
            ),
          ),
        ),
      ),
      //onStateChanged: (val) => setState(() => _currentHeight = val * widget.maxHeight),
    );
  }
}
