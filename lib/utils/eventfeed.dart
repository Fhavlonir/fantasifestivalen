import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../app.dart';
import '../utils/constants.dart';

class EventFeed extends StatefulWidget {
  final List<int>? artists;
  List<Event> events = [];
  EventFeed(List<int>? this.artists, {Key? key}) : super(key: key);

  @override
  _EventFeedState createState() => _EventFeedState();
}

class _EventFeedState extends State<EventFeed> {
  Stream<void> getEvents() async* {
    List<Event> newEvents = [];
    if (widget.artists != null) {
      List<Event> allEvents = [];
      List<Future> loadAllEvents = [];
      for (Event e in await isar.events.where().sortById().findAll()) {
        allEvents.add(e);
        loadAllEvents.add(e.artist.load());
      }
      await Future.wait(loadAllEvents);
      List<Future> loadFilteredEvents = [];
      for (Event e in allEvents) {
        if (widget.artists?.contains(e.artist.value?.id) ?? false) {
          newEvents.add(e);
          loadFilteredEvents.add(e.rule.load());
        }
      }
      await Future.wait(loadFilteredEvents);
      //for (Event e in artist?.events??[]) { //Someday, when Isar is patched...
    } else {
      newEvents = await isar.events.where().sortById().findAll();
    }
    List<Future> waitList = [];
    for (Event event in newEvents) {
      waitList.add(event.artist.load());
      waitList.add(event.rule.load());
    }
    await Future.wait(waitList);
    for (Event e in newEvents) {
      widget.events.add(e);
    }
    yield null;

    await for (final chunk in isar.events.watchLazy()) {
      Event? event = await isar.events.where().sortByIdDesc().findFirst();
      if (event != null) {
        await Future.wait([event.artist.load(), event.rule.load()]);
        widget.events.add(event);
      }
      if (widget.artists == null ||
          ((widget.artists?.contains((event?.artist.value?.id) ?? 0)) ??
              false)) {
        yield null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<void>(
        stream: getEvents(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (widget.events == []) {
            return Container();
          } else {
            List<Widget> tiles = [];
            for (Event event in widget.events) {
              tiles.add(Card(
                  color: Theme.of(context).colorScheme.primary,
                  elevation: 20,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        event.rule.value?.reward.toString() ?? '',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    title: Text(
                      event.rule.value?.name ?? '',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    trailing: Container(
                      constraints: BoxConstraints(maxWidth: 100),
                      child: Text(
                        event.artist.value?.name ?? '',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                    subtitle: Text(
                      event.comment ?? '',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  )));
            }
            return ListView(
              children: tiles.reversed.toList(),
            );
          }
        });
  }
}
