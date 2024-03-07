import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../../utils/constants.dart';
import '../../app.dart';

class LeaderboardsTable extends StatelessWidget {
  LeaderboardsTable({Key? key}) : super(key: key);

  Future<List> _updateLeaderboards() async {
    final teamResponse = await supabase
        .from('leaderboard')
        .select('name, score')
        .order('score', ascending: false)
        .limit(10)
        .execute();
    return teamResponse.data;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder(
            future: _updateLeaderboards(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<DataRow> rows = [];
                for (var entry in snapshot.data) {
                  rows.add(DataRow(cells: [
                    DataCell(Text(entry['name'] ?? '')),
                    DataCell(Text(entry['score'].toString() ?? '')),
                  ]));
                }
                return DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(child: Text('Lagnamn')),
                    ),
                    DataColumn(
                      label: Expanded(child: Text('Poäng')),
                    ),
                  ],
                  rows: rows,
                );
              } else {
                return SizedBox.shrink();
              }
            }));
  }
}

class LeaderboardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Topplista'),
      ),
      body: ListView(shrinkWrap: true, children: [
        Center(
            child: Card(
                color: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                      'Dessa är lagen som leder i Fantasifestivalen just nu!\nTopplistan uppdateras efter varje program',
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onPrimary)),
                ))),
        LeaderboardsTable()
      ]),
    );
  }
}
