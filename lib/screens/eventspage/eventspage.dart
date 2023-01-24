import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app.dart';

class EventsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventList>(context);
    final rules = Provider.of<RuleList>(context);
    final artists = Provider.of<ArtistList>(context);
    List<DataRow> eventRows = [];
    for (Event event in events.getAllEvents()) {
      eventRows.add(DataRow(cells: [DataCell(Text(artists.getArtist(event.getArtist()).getName())), DataCell(Text(rules.getRule(event.getRule()).getName())), DataCell(Text(rules.getRule(event.getRule()).getReward().toString()))]));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Händelser'),
      ),
      body: Center(
        child: ListView( 
          children: [
            Center( child: Card(
              color: Theme.of(context).splashColor,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text("De här sakerna har hänt i Melodifestivalen hittills, och ger plus- eller minuspoäng till artisterna i Fantasifestivalen, se Regler-sidan för mer information.",
                  style: Theme.of(context).textTheme.headline6
                )
              ))
            ),
            DataTable(
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
              rows: eventRows.reversed.toList(),
            )
          ]
        )
      ),
    );
  }
}
