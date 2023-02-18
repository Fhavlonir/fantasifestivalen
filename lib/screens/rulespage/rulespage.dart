import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../../utils/constants.dart';
import '../../app.dart';

class RulesTable extends StatelessWidget {
  const RulesTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Rule>> (
        future: isar.rules.where().sortByCategory().findAll(),
        builder: (BuildContext context, AsyncSnapshot<List<Rule>> snapshot) { 
          List<Rule> _rules = snapshot.data??[];
          List<DataRow> rows = [];
          for (Rule rule in _rules){
            rows.add(DataRow(cells: [
              DataCell(Text(rule.name??'')),
              DataCell(Text(rule.reward.toString()??'')),
              DataCell(Text(rule.category??'')),
            ]));
          }
          return DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text('Regel')
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text('Poäng')
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text('Kategori')
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
class RulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Regler'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [ 
          Center(child: Card(
            color: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: EdgeInsets.all(16),
                child: Text('- Alla lag måste innehålla fem artister till kostnadssumma av 100 Mellocash eller mindre.\n- Överblivna Mellocash återvänds som poäng.\n- Nedanstående regler kan ge eller dra ifrån poäng.\n- Fyndiga namn är obligatoriska.\n- Att lägga upp en screenshot av sitt lag på sociala medier är varmt rekommenderat.\n- Flest poäng vinner!', 
                style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.onPrimary)
              ),
            ),
          )),
          RulesTable()
        ]
      ),
    );
  }
}
