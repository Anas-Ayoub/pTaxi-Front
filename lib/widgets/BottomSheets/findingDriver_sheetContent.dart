import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/providers/map_provider.dart';
import 'package:taxi_app/services/here_service.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:taxi_app/widgets/buttons/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FindingDriverSheetContent extends StatelessWidget {
  const FindingDriverSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.findATaxi,
              style: getFontStyle(context).copyWith(fontSize: 25),
            ),
            const SizedBox(height: 5),
            Text(
              "1 KM",
              style: getFontStyle(context).copyWith(fontSize: 35, fontWeight: FontWeight.w800, color:primaryColor),
            ),
            Text(
              AppLocalizations.of(context)!.away,
              style: getFontStyle(context).copyWith(
                fontSize: 16,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 10),
            PrimaryButton(
              text: AppLocalizations.of(context)!.cancel,
              onPressed: () {
                showConfirmationDialog(
                    context, "Are you sure you want to cancel ?", () {
                  MapProvider provider = context.read<MapProvider>();
                  context.pop();
                  enableGesture(context);
                  showTripOverviewSheet(context);
                  animateToRoute(provider.currentRoute!, context);
                  provider.setIsFindingTaxi(false);
                });
              },
              color: errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
