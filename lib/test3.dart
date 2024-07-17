import 'package:flutter/material.dart';
import 'package:linear_timer/linear_timer.dart';

class AnimatedCardList extends StatefulWidget {
  const AnimatedCardList({super.key});

  @override
  _AnimatedCardListState createState() => _AnimatedCardListState();
}

class _AnimatedCardListState extends State<AnimatedCardList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<int> _cards = [];
  int _counter = 0;

  void _addCard() {
    final int index = _cards.length;
    _cards.add(_counter);
    _listKey.currentState!.insertItem(index);
    _counter++;
  }

  void _removeCard(int id) {
    final int index = _cards.indexOf(id);
    if (index != -1) {
      _listKey.currentState!.removeItem(
        index,
        (context, animation) => _buildCard(id, animation),
      );
      _cards.removeAt(index);
    }
  }

  Widget _buildCard(int id, Animation<double> animation) {
    return SizeTransition(
      key: ValueKey(id),
      sizeFactor: animation,
      child: Card(
        child: ListTile(
          title: Text('Card $id'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _removeCard(id),
          ),
          subtitle: LinearTimer(
            duration: Duration(seconds: 5),
            forward: false,
            color: Colors.amber,
            onTimerEnd: () => _removeCard(id),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Cards with Animation'),
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _cards.length,
        itemBuilder: (context, index, animation) {
          return SizeTransition(
            key: ValueKey(_cards[index]),
            sizeFactor: animation,
            child: Card(
              child: ListTile(
                title: Text('Card ${_cards[index]}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _removeCard(_cards[index]),
                ),
                subtitle: LinearTimer(
                  duration: Duration(seconds: 5),
                  forward: false,
                  color: Colors.amber,
                  onTimerEnd: () => _removeCard(_cards[index]),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCard,
        tooltip: 'Add Card',
        child: Icon(Icons.add),
      ),
    );
  }
}
