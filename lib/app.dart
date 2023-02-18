import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'screens/teampage/teampage.dart';
import 'screens/login/account_page.dart';
import 'screens/login/login.dart';
import 'screens/login/splash_page.dart';
import 'utils/constants.dart';

part 'app.g.dart';

@Collection()
class Artist {
  Artist(this.id, this.name, this.song, this.cost, this.heat, this.number,
      this.desc, this.imgcred, this.imgurl, this.timestamp);
  int id;
  String name;
  String song;
  int cost;
  int heat;
  int number;
  String desc;
  String imgcred;
  String imgurl;
  @Index()
  DateTime timestamp;
  @Backlink(to: 'artist')
  final events = IsarLinks<Event>();
}

@Collection()
class Rule {
  Rule(this.id, this.name, this.desc, this.category, this.reward, this.timestamp);
  int id;
  String name;
  String desc;
  String category;
  int reward;
  @Index()
  DateTime timestamp;
}

@Collection()
class Event {
  int id;
  final artist = IsarLink<Artist>();
  final rule   = IsarLink<Rule>();
  String comment;
  @Index()
  DateTime timestamp;

  Event(this.id, this.comment, this.timestamp);
}

class Team {
  List<int> ids;
  Team(List<int> this.ids);

  void updateAll(List<int> new_ids) {
    ids = new_ids.toList();
  }

  void updateArtist(position, id) {
    for (int i = 0; i < ids.length; i++) {
      if (ids[i] == id) {
        ids[i] = 0;
      }
    }
    ids[position] = id;
  }

  int getArtistId(int position) {
    return ids[position];
  }

  UnmodifiableListView<int> getTeamIds() {
    return UnmodifiableListView(ids);
  }
}

class Fantasifestivalen extends StatelessWidget {
  const Fantasifestivalen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fantasifestivalen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        canvasColor: Colors.pink.shade50,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(),
        '/account': (_) => const AccountPage(),
        '/teampage': (_) => const TeamPage(),
      },
    );
  }
}
