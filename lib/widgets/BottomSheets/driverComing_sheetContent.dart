import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/providers/app_provider.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:taxi_app/widgets/buttons/primary_button.dart';
import 'package:taxi_app/widgets/profile_container.dart';

class DrivingComingSheetContent extends StatefulWidget {
  const DrivingComingSheetContent({super.key});

  @override
  State<DrivingComingSheetContent> createState() =>
      _DrivingComingSheetContentState();
}

class _DrivingComingSheetContentState extends State<DrivingComingSheetContent> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    return PopScope(
      canPop: false,
      child: SingleChildScrollView(
        child: InkWell(
          onTap: () => context.pop(),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  "Your Driver will arrive in",
                  style: getFontStyle(context).copyWith(fontSize: 20),
                ),
                Text(
                  "3 MIN",
                  style: getFontStyle(context).copyWith(
                      fontSize: 27,
                      fontWeight: FontWeight.w800,
                      color: primaryColor),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: getScreenWidth(context) * 0.2,
                      child: Column(
                        children: [
                          const Center(
                            child: const ProfileFrame(
                              size: 60,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "AYOUB",
                            style: getFontStyle(context)
                                .copyWith(fontWeight: FontWeight.bold, ), textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: getScreenWidth(context) * 0.5,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/brand.png",
                            width: 50,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(width: 1.3),
                            ),
                            height: 30,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "123456",
                                    style: GoogleFonts.dosis(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 21),
                                  ),
                                  const VerticalDivider(
                                    color: Colors.black,
                                    thickness: 1.7,
                                    endIndent: 2,
                                    indent: 2,
                                  ),
                                  Text(
                                    "ب",
                                    style: GoogleFonts.dosis(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                  const VerticalDivider(
                                    color: Colors.black,
                                    thickness: 1.7,
                                    endIndent: 2,
                                    indent: 2,
                                  ),
                                  Text(
                                    "27",
                                    style: GoogleFonts.dosis(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                        width: getScreenWidth(context) * 0.2,
                        child: Image.asset("assets/dacia.png",),),
                  ],
                ),
                const Divider(),
                // const SizedBox(height: 5),
                Text(
                  "70 MAD",
                  style: getFontStyle(context)
                      .copyWith(fontSize: 30, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        color: errorColor,
                        height: 45,
                        text: "Cancel",
                        onPressed: () {
                          context.pop();
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PrimaryButton(
                        height: 45,
                        text: "Call",
                        onPressed: () {},
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
