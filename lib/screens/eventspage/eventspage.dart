import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app.dart';
//import 'package:cached_network_image/cached_network_image.dart';

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
        child: Column(
          children: [ Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: 480,
                child: Text(_artists.getArtist(_event.getArtist()).getName(),
                overflow: TextOverflow.clip, 
                style: Theme.of(context).textTheme.headline4),
            ),
            Text(_rules.getRule(_event.getRule()).getName(),
                style: Theme.of(context).textTheme.headline5),
            ]),
            Text(_event.getComment() ?? '',
                style: Theme.of(context).textTheme.headline6),
          ]),
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
          shrinkWrap: true,
          children: items,
        ),
      );
  }
}
