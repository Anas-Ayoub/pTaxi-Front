import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/models/car_pick.dart';
import 'package:taxi_app/utils/utils.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:taxi_app/widgets/primary_button.dart';

class CarPickScreen extends StatefulWidget {
  const CarPickScreen({super.key});

  @override
  State<CarPickScreen> createState() => _CarPickScreenState();
}

class _CarPickScreenState extends State<CarPickScreen> {
  List<CarPick> carList = [];
  List<String> modelList = [];
  String? selectedBrand;
  String? selectedModel;
  bool _isLoading = true; // Add this

  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final SuggestionsController<String> _modelSuggestionsController =
      SuggestionsController();

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final String response = await rootBundle.loadString('assets/car-list.json');
    final data = json.decode(response) as List<dynamic>;

    setState(() {
      carList = data.map((json) => CarPick.fromJson(json)).toList();
      _isLoading = false;
    });
    log(carList.length.toString());
  }

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getBackgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Brand & Model', style: getFontStyle(context)),
          backgroundColor: Colors.transparent,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Image.asset(
                          "assets/car.png",
                          width: 225,
                        ),
                      ),
                      TypeAheadField<String>(
                        controller: _brandController,
                        suggestionsCallback: (pattern) {
                          return carList
                              .where((car) => car.brand
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()))
                              .map((car) => car.brand)
                              .toList();
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion, style: getFontStyle(context).copyWith(fontWeight: FontWeight.bold),),
                          );
                        },
                        onSelected: (suggestion) {
                          setState(() {
                            _brandController.clear();
                            selectedBrand = null;
                            selectedBrand = suggestion;
                            _brandController.text = suggestion;
                            modelList.clear();
                            modelList = carList
                                .firstWhere((car) => car.brand == suggestion)
                                .models;
                            selectedModel = null; // Reset the selected model
                            _modelController.clear();
                          });
                        },
                        builder: (context, controller, focusNode) {
                          return TextField(
                            controller: controller,
                            focusNode: focusNode,
                            style: getFontStyle(context).copyWith(fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                labelText: 'Select Car',
                                labelStyle: getFontStyle(context),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: primaryColor)),
                                fillColor: primaryColor.withOpacity(0.3),
                                filled: true),
                          );
                        },
                      ),
                      SizedBox(height: 8,),
                      // if (modelList.isNotEmpty)
                      Visibility(
                        visible: modelList.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TypeAheadField<String>(
                            
                            suggestionsController: _modelSuggestionsController,
                            controller: _modelController,
                            suggestionsCallback: (pattern) {
                              return modelList
                                  .where((model) => model
                                      .toLowerCase()
                                      .contains(pattern.toLowerCase()))
                                  .toList();
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion, style: getFontStyle(context).copyWith(fontWeight: FontWeight.bold),),
                              );
                            },
                            onSelected: (suggestion) {
                              setState(() {
                                selectedModel = suggestion;
                                _modelController.text = suggestion;
                              });
                            },
                            builder: (context, controller, focusNode) {
                              return TextField(
                                controller: controller,
                                focusNode: focusNode,
                                style: getFontStyle(context).copyWith(fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                    labelText: 'Select Model',
                                    labelStyle: getFontStyle(context),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2, color: primaryColor)),
                                    fillColor: primaryColor.withOpacity(0.3),
                                    filled: true),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      PrimaryButton(
                        text: "Next",
                        onPressed: () {
                          log(_brandController.text);
                          log(_modelController.text);
                        },
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
