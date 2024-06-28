import 'package:flutter/material.dart';
import 'package:taxi_app/screens/map_provider.dart';
import 'package:taxi_app/widgets/bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapProvider(),
          const DraggableBottomSheet(),
        ],
      ),
    );
  }
}
