import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app.dart';

class RuleItem extends StatelessWidget {
  final Rule rule;
  const RuleItem(this.rule, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RuleList>(builder: (context, rules, child) {
      return Container(
        constraints: BoxConstraints(minHeight: 100),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration( 
          color: Theme.of(context).splashColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [ 
              Container(
                  child: Row( 
                  children: [
                    SizedBox(
                      width: 360,
                      child: Text(rule.getName(),
                        style: Theme.of(context).textTheme.headline5),
                    ),
                    SizedBox(
                      width: 80,
                      child: Text(rule.getReward().toString(),
                        style: Theme.of(context).textTheme.headline6),
                    ),
                    Text(rule.getCategory().toString(),
                        style: Theme.of(context).textTheme.headline6),
                  ]),
              ),
              Text(rule.getDesc() ?? '',
                style: Theme.of(context).textTheme.caption)
            ]
          ),
        ),
      );
    });
  }
}

class RulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Consumer<RuleList>(builder: (context, rules, child) {
      List<RuleItem> items = [];
      for (Rule rule in rules.getAllRules()) {
        items.add(RuleItem(rule));
      }
      return Scaffold(
        appBar: AppBar(
          title: Text('Regler'),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [ 
            Container(
              decoration: BoxDecoration(color: Theme.of(context).splashColor),
              child: Container(
                margin: EdgeInsets.only(left: 36, right: 36, top: 36, bottom: 16),
                child: Row(
                  children: [
                    Container(
                      width: 360,
                      child: Text('Regelnamn',
                        style: Theme.of(context).textTheme.headline5,),
                    ),
                    Container(
                      width: 80,
                      child: Text('Poäng',
                        style: Theme.of(context).textTheme.headline5,),
                    ),
                    Container(
                      width: 240,
                      child: Text('Kategori', 
                        style: Theme.of(context).textTheme.headline5,),
                    ),
                  ],
                ),
              )
            )]..addAll(items)
        ),
      );
    }));
  }
}
