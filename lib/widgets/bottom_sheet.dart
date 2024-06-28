import 'package:flutter/material.dart';
import 'package:taxi_app/services/authentication_service.dart';
import 'package:taxi_app/widgets/test.dart';

class DraggableBottomSheet extends StatefulWidget {
  final double maxHeight;
  final Widget content;
  const DraggableBottomSheet({super.key, this.maxHeight = 0.3, required this.content});

  @override
  State<DraggableBottomSheet> createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  late DraggableScrollableController _bottomSheetController;
  final double _minHeight = 0.04;
  // final double _maxHeight = 1; "for 3 snaps pos"
  // final double _maxHeight = 0.3;

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
      snapSizes: [],
      initialChildSize: widget.maxHeight,
      minChildSize: _minHeight,
      maxChildSize: widget.maxHeight,
      builder: (_, controller) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        child: Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          color: Colors.grey,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  if (_bottomSheetController.size == widget.maxHeight) {
                    _bottomSheetController.animateTo(
                      _minHeight,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    _bottomSheetController.animateTo(
                      widget.maxHeight,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                // onDoubleTap: () {
                //   _bottomSheetController.animateTo(_maxHeight,
                //       duration: const Duration(milliseconds: 450),
                //       curve: Curves.easeInOutCubic);
                // },
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
              SingleChildScrollView(child: widget.content),
            ],
          ),
        ),
      ),
      //onStateChanged: (val) => setState(() => _currentHeight = val * widget.maxHeight),
    );
  }
}
