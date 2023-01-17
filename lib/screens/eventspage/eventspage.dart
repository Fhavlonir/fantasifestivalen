import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app.dart';

class EventItem extends StatelessWidget {
  final ArtistList _artists;
  final RuleList _rules;
  final Event _event;
  const EventItem(this._event, this._artists, this._rules, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EventList>(builder: (context, events, child) {
      int _rule = _event.getRule();
      return Container(
        constraints: BoxConstraints(minHeight: 100),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration( 
          color: Theme.of(context).splashColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
        margin: EdgeInsets.all(16),
          child: Column( children: [ 
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  width: 360,
                  child: Text(_artists.getArtist(_event.getArtist()).getName(),
                    overflow: TextOverflow.clip, 
                    style: Theme.of(context).textTheme.headline5),
              ),
              Container(
                  width: 240,
                  child: Text(_rules.getRule(_event.getRule()).getName(),
                    style: Theme.of(context).textTheme.headline6),
              ),
              Container(
                width: 80,
                child: Text(_rules.getRule(_event.getRule()).getReward().toString(),
                    style: Theme.of(context).textTheme.headline5),
              )
              ]),
            Text(_event.getComment() ?? '',
                style: Theme.of(context).textTheme.caption),
          ]),
        ),
      );
    });
  }
}

class EventsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      final events = Provider.of<EventList>(context);
      final rules = Provider.of<RuleList>(context);
      final artists = Provider.of<ArtistList>(context);
      List<EventItem> items = [];
      for (Event event in events.getAllEvents()) {
        items.add(EventItem(event, artists, rules));
      }
      return Scaffold(
        appBar: AppBar(
          title: Text('Händelser'),
        ),
        body: ListView(
          children: [
            Container(
              decoration: BoxDecoration( color: Theme.of(context).splashColor,),
              child: Container(
                margin: EdgeInsets.only(left: 36, right: 36, top: 36, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[
                    Container(
                      width: 360,
                      child: Text('Artist',
                        style: Theme.of(context).textTheme.headline5,),
                    ),
                    Container(
                      width: 240,
                      child: Text('Regel', 
                        style: Theme.of(context).textTheme.headline5,),
                    ),
                    Container(
                      width: 80,
                      child: Text('Poäng',
                        style: Theme.of(context).textTheme.headline5,), 
                    ),
                  ],
                ),
              )
            )
          ]..addAll(items)
        ),
      );
  }
}
