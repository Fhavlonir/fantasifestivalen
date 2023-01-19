import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app.dart';

class RulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Consumer<RuleList>(builder: (context, rules, child) {
      List<DataRow> ruleRows = [];
      
      for (Rule rule in rules.getAllRules()) {
        ruleRows.add(DataRow(cells: [DataCell(Text(rule.getName())), DataCell(Text(rule.getReward().toString())), DataCell(Text(rule.getCategory().toString()))]));
      }
      return Scaffold(
        appBar: AppBar(
          title: Text('Regler'),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [ 
            Center(child: Card(
              color: Theme.of(context).splashColor,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('- Alla lag måste innehålla fem artister till kostnadssumma av 100 Mellocash eller mindre.\n- Nedanstående regler kan ge eller dra ifrån poäng.\n- Fyndiga namn är obligatoriska.\n- Att lägga upp en screenshot av sitt lag på sociala medier är varmt rekommenderat.\n- Flest poäng vinner!', 
                style: Theme.of(context).textTheme.headline6),
              ),
            )),
            DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text('Regelnamn')
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
              rows: ruleRows,
            ),
          ]
        ),
      );
    }));
  }
}
