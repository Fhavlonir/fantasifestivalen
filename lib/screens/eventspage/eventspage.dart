import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app.dart';
//import 'package:cached_network_image/cached_network_image.dart';

class EventsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return (Consumer<EventList>(builder: (context, events, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Händelser'),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: Text('Test'),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: Text('Test'),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: Text('Test'),
            ),
          ],
        ),
      );
    }));
  }
}
