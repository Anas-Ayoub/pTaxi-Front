import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taxi_app/Router/route_names.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:taxi_app/widgets/primary_button.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:taxi_app/widgets/top_snackbar.dart';

class CityPickScreen extends StatefulWidget {
  const CityPickScreen({super.key});

  @override
  State<CityPickScreen> createState() => _CityPickScreenState();
}

class _CityPickScreenState extends State<CityPickScreen> {
  List<dynamic> _cities = [];
  String? _selectedCity;

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  Future<void> _loadCities() async {
    final String response = await rootBundle.loadString('assets/cities.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      _cities = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getBackgroundDecoration(),
      child: Scaffold(
        appBar: AppBar(title: Text("Choose City", style: getFontStyle(context),), centerTitle: true, backgroundColor: Colors.transparent,),
        backgroundColor: Colors.white.withOpacity(0),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15,),
                Text("Please Choose your city", style: getFontStyle(context).copyWith(fontSize: 18),),
                Image.asset(
                  "assets/4.png",
                  width: getScreenWidth(context) * 0.5,
                ),
                const SizedBox(
                  height: 25,
                ),
                _cities.isEmpty
                    ? const CircularProgressIndicator()
                    : DropdownMenu<String>(
                      
                        menuHeight: getScreenHeight(context) * 0.5,
                        enableFilter: true,
                        requestFocusOnTap: true,
                        leadingIcon: const Icon(Icons.search),
                        
                        label: Text(
                          'City',
                          style: getFontStyle(context),
                        ),
                        inputDecorationTheme: InputDecorationTheme(
                          activeIndicatorBorder: BorderSide.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 1.5,
                              color: primaryColor,
                            ),
                          ),
                          filled: true,
                          fillColor: primaryColor.withOpacity(0.3),
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        ),
                        onSelected: (String? newValue) {
                          setState(() {
                            _selectedCity = newValue!;
                          });
                        },
                        
                        dropdownMenuEntries:
                            _cities.map<DropdownMenuEntry<String>>(
                          (dynamic city) {
                            return DropdownMenuEntry<String>(
                              value: city['ville'],
                              label: city['ville'],
                              // leadingIcon: Icon(icon.icon),
                            );
                          },
                        ).toList(),
                      ),
                const SizedBox(
                  height: 40,
                ),
                PrimaryButton(
                  text: "Next",
                  onPressed: () {
                    if (_selectedCity == null) {
                      mySnackBar(
                          context: context,
                          message: "Please Select a city",
                          snackBarType: SnackBarType.info);
                    } else {
                      print("CITY = ${_selectedCity}");
                      context.pushNamed(RouteNames.main);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
