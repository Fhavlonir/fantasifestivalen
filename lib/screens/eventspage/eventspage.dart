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
      body: Column( 
          children: [
            Center( child: Card(
              color: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text("De här sakerna har hänt i Melodifestivalen hittills och ger plus- eller minuspoäng till artisterna i Fantasifesivalen, se Regler-sidan för med information.",
                  style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.onPrimary)
                )
              )
            )),
            Expanded(
              child: Container(
                constraints: BoxConstraints(maxWidth: 600),
                child:  EventFeed(null),
              )
            )
          ]
      ),
    );
  }
}
