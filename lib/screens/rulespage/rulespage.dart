import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app.dart';
//import 'package:cached_network_image/cached_network_image.dart';

class RuleItem extends StatelessWidget {
  final int id;
  const RuleItem(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RuleList>(builder: (context, rules, child) {
      var rule = rules.getRule(id);
      return SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(rule.getName(),
                style: Theme.of(context).textTheme.headline6),
            Text(rule.getReward().toString(),
                style: Theme.of(context).textTheme.headline4),
            Text(rule.getCategory().toString(),
                style: Theme.of(context).textTheme.headline4),
            Text(rule.getDesc() ?? '',
                style: Theme.of(context).textTheme.headline4)
          ]),
      );
    });
  }
}

class RulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Consumer<RuleList>(builder: (context, rules, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Regler'),
        ),
        body: ListView(
          shrinkWrap: true,
          children:
              List<int>.generate(67, (index) => index + 1, growable: false)
                  .map((id) => RuleItem(id))
                  .toList(),
        ),
      );
    }));
  }
}
