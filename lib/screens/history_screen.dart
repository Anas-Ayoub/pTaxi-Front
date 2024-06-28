import 'package:flutter/material.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/widgets/toggle_switcher_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, title: Text("Ride history"),),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.green.shade100,
                    ),
                    child: TabBar(
                      controller: _controller,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: const EdgeInsets.all(5),
                      dividerColor: Colors.transparent,
                      indicator: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: const Color.fromARGB(255, 0, 0, 0),
                      tabs: const [
                        TabItem(title: 'Completed'),
                        TabItem(title: 'Cancelled'),
                      ],
                      onTap: (value) {},
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                    children: [
                      Center(
                          child: Text(
                        "No Data",
                        style: getFontStyle(context),
                      )),
                      Center(
                          child: Text(
                        "No Data",
                        style: getFontStyle(context),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
     
    );
  }
}
