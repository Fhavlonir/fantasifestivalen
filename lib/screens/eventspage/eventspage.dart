import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../../app.dart';
import '../../utils/constants.dart';
import '../../utils/eventfeed.dart';

class EventsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
                child: Text("De här sakerna har hänt i Melodifestivalen hittills och ger plus- eller minuspoäng till artisterna i Fantasifesivalen, se Regler-sidan för med information.",
                  style: Theme.of(context).textTheme.headline6
                )
              )
            )),
            EventFeed(null),
          ]
        )
      ),
    );
  }
}
