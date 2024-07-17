import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/search.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/providers/map_provider.dart';
import 'package:taxi_app/services/here_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GeocodingSearchBar extends StatefulWidget {
  const GeocodingSearchBar({super.key});

  @override
  _GeocodingSearchBarState createState() => _GeocodingSearchBarState();
}

class _GeocodingSearchBarState extends State<GeocodingSearchBar> {
  TextEditingController _searchController = TextEditingController();
  final SearchEngine _searchEngine = SearchEngine();

  Future<List<Suggestion>> _getSuggestions(String query) async {
    if (query.isEmpty) {
      return [];
    }
    GeoCoordinates _currentLocation =
        context.read<MapProvider>().currentLocation!;
    SearchOptions searchOptions = SearchOptions();
    searchOptions.languageCode = LanguageCode.enUs;
    searchOptions.maxItems = 5;

    TextQueryArea queryArea = TextQueryArea.withCenter(_currentLocation);

    Completer<List<Suggestion>> completer = Completer();
    _searchEngine.suggest(
      TextQuery.withArea(query, queryArea),
      searchOptions,
      (SearchError? searchError, List<Suggestion>? list) {
        if (searchError != null) {
          print("Autosuggest Error: " + searchError.toString());
          completer.complete([]);
          return;
        }

        completer.complete(list ?? []);
      },
    );

    return completer.future;
  }

  void _onSuggestionSelected(Suggestion suggestion) {
    if (suggestion.place != null) {
      Place place = suggestion.place!;
      GeoCoordinates geoCoordinates = place.geoCoordinates!;
      String selectedPlace = place.address.addressText;
      _searchController.text = selectedPlace;

      log('Selected Place: $selectedPlace');
      log('Coordinates: ${geoCoordinates.latitude}, ${geoCoordinates.longitude}');
      animateToLocation(context, geoCoordinates);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TypeAheadField<Suggestion>(
        builder: (context, controller, focusNode) {
          _searchController = controller;
          return TextField(
            controller: _searchController,
            style: getFontStyle(context)
                .copyWith(fontSize: 17, fontWeight: FontWeight.bold),
            focusNode: focusNode,
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/search.png",
                    width: 10,
                  ),
                ),
                labelText: AppLocalizations.of(context)!.searchPlaces,
                labelStyle: getFontStyle(context).copyWith(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
                // border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 2.5, color: Colors.green),
                    borderRadius: BorderRadius.circular(20)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 2, color: Color.fromARGB(255, 116, 116, 116)),
                    borderRadius: BorderRadius.circular(50)),
                fillColor: Colors.white.withOpacity(0.6),
                filled: true),
          );
        },
        suggestionsCallback: _getSuggestions,
        itemBuilder: (context, Suggestion suggestion) {
          return ListTile(
            leading: Icon(Icons.location_on_rounded, size: 25),
            horizontalTitleGap: 8,
            titleAlignment: ListTileTitleAlignment.titleHeight,
            title: Text(
              suggestion.title,
              style:
                  getFontStyle(context).copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: suggestion.place != null
                ? Text(suggestion.place!.address.addressText)
                : null,
          );
        },
        onSelected: _onSuggestionSelected,
        emptyBuilder: (context) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(AppLocalizations.of(context)!.noSuggestionsFound),
          );
        },
      ),
    );
  }
}
