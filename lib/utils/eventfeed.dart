import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../../app.dart';
import '../../utils/constants.dart';

class EventFeed extends StatelessWidget {
  const EventFeed(List<int>? this.artists, {Key? key}) : super(key: key);
  final List<int>? artists;

  Future<List<Event>> getEvents() async {
    List<Event> events=[];
    if (artists != null){
      List<Event> allEvents = [];
      List<Future> loadAllEvents = [];
      for (Event e in await isar.events.where().sortByIdDesc().findAll()){
        allEvents.add(e);
        loadAllEvents.add(e.artist.load());
      }
      await Future.wait(loadAllEvents);
      List<Future> loadFilteredEvents = [];
      for (Event e in allEvents){
        if (artists?.contains(e.artist.value?.id)??false) {
          events.add(e);
          loadFilteredEvents.add(e.rule.load());
        }
      }
      await Future.wait(loadFilteredEvents);
      //for (Event e in artist?.events??[]) { //Someday, when Isar is patched...

    } else {
      events = await isar.events.where().sortByIdDesc().findAll();
    }
    List<Future> waitList = [];
    for (Event event in events) {
      waitList.add(event.artist.load());
      waitList.add(event.rule.load());
    }
    await Future.wait(waitList);
    print(events[0].rule.value);
    return events;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Event>> (
        future: getEvents(),
        builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) { 
          List<Event> _events = snapshot.data??[];
          List<DataRow> rows = [];
          for (Event event in _events){
            rows.add(DataRow(cells: [
              DataCell(Text(event.artist.value?.name??'')),
              DataCell(Text(event.rule.value?.name??'')),
              DataCell(Text(event.rule.value?.reward.toString()??'')),
            ]));
          }
          return DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text('Artist')
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text('Vad de gjort')
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text('Poäng')
                ),
              )
            ],
            rows: rows,
          );
        }
      )
    );
  }
}

