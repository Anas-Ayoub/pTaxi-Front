import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:pinput/pinput.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  Map<int, LinearTimerController>  controllers = {};

  int _cardCounter = 0;
  List<int> _cards = [];

  void addCard() {
    setState(() {
      _cards.add(_cards.length+1);
      controllers[_cards.length+1] = LinearTimerController(this);
    });
  }

  void removeCard(int id) {
    
    setState(() {
      _cards.removeAt(id);
      controllers.remove(id);
    });
    log("REMOVED $id");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Stack(
        children: <Widget>[
          Placeholder(
            color: Colors.white,
          ), // Replace with your HomePage content
          ListView(children: [
            for (int i = 0; i < _cards.length; i++)
            GestureDetector(
              onTap: () => removeCard(i),
              child: CardWithTimer(
                key: ValueKey(i),
                id: i,
                onTimerEnd: () => removeCard(i),
              ),
            ),
          ],),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addCard,
        child: Icon(Icons.add),
      ),
    );
  }
}

class CardWithTimer extends StatefulWidget {
  final int id;
  final VoidCallback onTimerEnd;

  const CardWithTimer({Key? key, required this.id, required this.onTimerEnd}) : super(key: key);

  @override
  _CardWithTimerState createState() => _CardWithTimerState();
}

class _CardWithTimerState extends State<CardWithTimer> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('Card ${widget.id + 1}'),
            subtitle: Text('This is card number ${widget.id + 1}'),
          ),
          LinearTimer(
            key: widget.key,
            duration: Duration(seconds: 5),
            forward: false,
            color: Colors.amber,
            onTimerEnd: widget.onTimerEnd,
          ),
        ],
      ),
    );
  }
}