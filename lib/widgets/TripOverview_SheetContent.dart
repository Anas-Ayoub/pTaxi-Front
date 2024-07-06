import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/providers/map_provider.dart';
import 'package:taxi_app/widgets/primary_button.dart';
import 'package:timelines/timelines.dart';
// import 'package:timeline_tile/timeline_tile.dart';

class TripOverviewSheetcontent extends StatefulWidget {
  const TripOverviewSheetcontent({super.key});

  @override
  State<TripOverviewSheetcontent> createState() =>
      _TripOverviewSheetcontentState();
}

class _TripOverviewSheetcontentState extends State<TripOverviewSheetcontent> {
  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context, listen: true);
    String startLocation = mapProvider.currentLocationName;
    String endtLocation = mapProvider.toLocationName;
    int nbPassenger = mapProvider.nbPassenger;

    return SingleChildScrollView(
      child: Column(
        children: [
          FixedTimeline.tileBuilder(
            theme: TimelineThemeData(

              nodeItemOverlap: true,
              color: primaryColor,
              nodePosition: 0,
              indicatorTheme: IndicatorThemeData(size: 30),
              connectorTheme: ConnectorThemeData(
                thickness: 4,
              ),
            ),
            builder: TimelineTileBuilder.connected(
              
              connectionDirection: ConnectionDirection.before,
              itemCount: 2,
              contentsBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(startLocation, style: getFontStyle(context)),
                  );
                } else if (index == 1) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(endtLocation, style: getFontStyle(context)),
                  );
                }
              },
              connectorBuilder: (context, index, type) {
                if (index == 0) {
                  return SolidLineConnector(
                    color: Colors.blue,
                  );
                } else if (index == 1) {
                  return SolidLineConnector(
                    color: Colors.blue,
                  );
                } else {
                  return null;
                }
              },
              indicatorBuilder: (context, index) {
                if (index == 0) {
                  return DotIndicator(
                    color: Colors.blue,
                    child: Icon(Icons.circle, color: Colors.white, size: 15,),
                  );
                } else if (index == 1) {
                  return DotIndicator(
                    color: Colors.green,
                    child: Icon(Icons.location_on, color: Colors.white),
                  );
                }
              },
            ),
          ),
          // SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/dollar.png",
                        width: 50,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "MAD 50",
                        style: getFontStyle(context).copyWith(fontSize: 20),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "(Fixed Price)",
                        style: getFontStyle(context).copyWith(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "4.5 KM",
                style: getFontStyle(context).copyWith(fontSize: 23),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  iconSize: 40,
                  onPressed: () {
                    mapProvider.decreaseNbPassenger();
                  },
                  icon: Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      nbPassenger.toString(),
                      style: getFontStyle(context).copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Passenger(s)"),
                  ],
                ),
                IconButton(
                  iconSize: 40,
                  onPressed: () {
                    mapProvider.increaseNbPassenger();
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info,
                    color: primaryColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Travel Time Arround 15min",
                    style: getFontStyle(context),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: primaryColor.withOpacity(0.3),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          PrimaryButton(
            text: "Find a Taxi",
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
