import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_border/progress_border.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/providers/app_provider.dart';
import 'package:taxi_app/providers/map_provider.dart';
import 'package:taxi_app/services/here_service.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:taxi_app/widgets/buttons/primary_button.dart';
import 'package:taxi_app/widgets/profile_container.dart';

class RideRequestCard extends StatefulWidget {
  final String? name;
  final String? carModel;
  final double? distance;
  final int? time;
  final VoidCallback onCancelCallBack;
  final VoidCallback onAcceptCallBack;
  const RideRequestCard({super.key, this.name = "N/A", this.carModel="Dacia", this.distance= 2.6, this.time = 15, required this.onCancelCallBack, required this.onAcceptCallBack});
  // final  VoidCallback func;
  @override
  _RideRequestCardState createState() => _RideRequestCardState();
}

class _RideRequestCardState extends State<RideRequestCard>
    with SingleTickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 20),
  );
  @override
  void initState() {
    super.initState();
    animationController.forward();
    animationController.addListener(() {
      if (animationController.status == AnimationStatus.completed) {
        log("FINISHED");
        widget.onCancelCallBack();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.cyan,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(22),
          border: ProgressBorder.all(
              color: Color.fromARGB(255, 62, 236, 68),
              progress: animationController.value,
              width: 7,
              clockwise: false),
        ),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    ProfileFrame(
                      size: 50,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text(
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            widget.name!,
                            style: getFontStyle(context).copyWith(fontSize: 18),
                          ),
                          SizedBox(width: 2),
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          Text("4.7"),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "(174 rides)",
                            style: getFontStyle(context),
                          )
                        ]),
                        const SizedBox(
                          height: 2.5,
                        ),
                        Text(
                          widget.carModel!,
                          style: getFontStyle(context).copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.distance}",
                          style: getFontStyle(context).copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 2.5,
                        ),
                        Text(
                          "${widget.time} min",
                          style: getFontStyle(context).copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
                Text(
                  "50 MAD",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w800, fontSize: 30),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: PrimaryButton(
                          height: 45,
                          color: errorColor,
                          text: "Cancel",
                          onPressed: widget.onCancelCallBack,
                        ),
                      ),
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: PrimaryButton(
                          height: 45,
                          color: primaryColor,
                          text: "Accept",
                          onPressed: () {
                            widget.onAcceptCallBack();
                            context.read<AppProvider>().setCards([]);
                            context.read<MapProvider>().setIsFindingTaxi(false);
                            animateToRoute(context.read<MapProvider>().currentRoute!, context);
                            showDriverComingSheet(context.read<AppProvider>().mainScreenContext!);
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
