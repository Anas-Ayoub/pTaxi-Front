import 'package:flutter/material.dart';
import 'package:here_sdk/animation.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/providers/map_provider.dart';
import 'package:taxi_app/services/here_service.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:taxi_app/widgets/buttons/primary_button.dart';
import 'package:timelines/timelines.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    String distanceInKm = mapProvider.lengthInKilometers;
    int travelTimeInMinutes = mapProvider.estimatedTravelTimeInMinutes;
    int trafficDelay = mapProvider.trafficDelay;

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
                    child: Icon(
                      Icons.circle,
                      color: Colors.white,
                      size: 15,
                    ),
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
                      Column(
                        children: [
                          Text(
                            "50 " + AppLocalizations.of(context)!.mad,
                            style: getFontStyle(context).copyWith(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            AppLocalizations.of(context)!.fixedPrice,
                            style: getFontStyle(context).copyWith(
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "$distanceInKm " + AppLocalizations.of(context)!.km,
                style: getFontStyle(context)
                    .copyWith(fontSize: 23, fontWeight: FontWeight.bold),
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
                    Text(AppLocalizations.of(context)!.passengerS),
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
          const SizedBox(
            height: 10,
          ),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: primaryColor.withOpacity(0.3),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.info,
                    color: primaryColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                            .travelTimeAround(travelTimeInMinutes),
                        style: getFontStyle(context)
                            .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      trafficDelay == 0
                          ? Container()
                          : Text(
                              AppLocalizations.of(context)!
                                  .estimatedTrafficDelay(trafficDelay),
                              style: getFontStyle(context).copyWith(
                                color: errorColor,
                                fontWeight: FontWeight.bold,
                                // fontStyle: FontStyle.italic
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          PrimaryButton(
            text: AppLocalizations.of(context)!.findATaxi,
            onPressed: () {
              showFindingTaxiSheet(context);
              flyToUserLocation(context);
              zoomCameraTo(context, 7000);
              mapProvider.setIsFindingTaxi(true);
            },
          )
        ],
      ),
    );
  }
}
