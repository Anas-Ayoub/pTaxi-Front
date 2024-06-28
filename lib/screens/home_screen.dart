import 'package:flutter/material.dart';
import 'package:taxi_app/screens/map_provider.dart';
import 'package:taxi_app/widgets/bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget sheetContent = DraggableBottomSheet(content: Column(),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // TextButton(
            //   onPressed: () {
            //     setState(
            //       () {
            //         sheetContent = DraggableBottomSheet(
            //           maxHeight: 0.5,
            //         );
            //       },
            //     );
            //   },
            //   child: Center(
            //     child: Text("child"),
            //   ),
            // ),
            MapProvider(),
            sheetContent,
          ],
        ),
      ),
    );
  }
}
