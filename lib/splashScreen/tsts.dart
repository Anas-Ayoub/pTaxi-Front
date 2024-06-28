import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesList extends StatefulWidget {
  @override
  _SharedPreferencesListState createState() => _SharedPreferencesListState();
}

class _SharedPreferencesListState extends State<SharedPreferencesList> {
  Map<String, Object> _prefsMap = {};

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    Map<String, Object> prefsMap = {};
    for (String key in keys) {
      final value = prefs.get(key);
      prefsMap[key] = value!;
    }

    setState(() {
      _prefsMap = prefsMap;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: _prefsMap.length,
        itemBuilder: (context, index) {
          final key = _prefsMap.keys.elementAt(index);
          final value = _prefsMap[key];

          return ListTile(
            title: Text('$key', ),
            subtitle: Text('$value'),
          );
        },
      ),
    );
  }
}
