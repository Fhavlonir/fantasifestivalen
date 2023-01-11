import 'dart:collection';

import 'package:flutter/material.dart';

import 'screens/teampage/teampage.dart';
import 'screens/login/account_page.dart';
import 'screens/login/login.dart';
import 'screens/login/splash_page.dart';
import 'package:provider/provider.dart';

class Artist {
  Artist(this._name, this._song, this._cost, this._heat, this._number, this._imgpath,
      this._desc, this._imgcred, this._imgurl);
  final String _name;
  final String _song;
  final int _cost;
  final int _heat;
  final int _number;
  final String _imgcred;
  final String _imgurl;
  final String _imgpath;
  final String _desc;
  getName() => _name;
  getSong() => _song;
  getCost() => _cost;
  getHeat() => _heat;
  getNumber() => _number;
  getImgCred() => _imgcred;
  getImgUrl() => _imgurl;
  getImg() => _imgpath + ".jpg";
  //getThumb() => _imgpath + "_thumb.jpg";
  getDesc() => _desc;
}

class ArtistList extends ChangeNotifier {
  final nullArtist = Artist('Välj Artist', '', 0, 0, 0, "", "", "", "");
  static const dummy =
      'Träutensilierna i ett tryckeri äro ingalunda en oviktig faktor, för trevnadens, ordningens och ekonomiens upprätthållande, och dock är det icke sällan som sorgliga erfarenheter göras på grund af det oförstånd med hvilket kaster, formbräden och regaler tillverkas och försäljas Kaster som äro dåligt hopkomna och af otillräckligt.\n\nTräutensilierna i ett tryckeri äro ingalunda en oviktig faktor, för trevnadens, ordningens och ekonomiens upprätthållande, och dock är det icke sällan som sorgliga erfarenheter göras på grund af det oförstånd med hvilket kaster, formbräden och regaler tillverkas och försäljas Kaster som äro dåligt hopkomna och af otillräckligt.\n\nTräutensilierna i ett tryckeri äro ingalunda en oviktig faktor, för trevnadens, ordningens och ekonomiens upprätthållande, och dock är det icke sällan som sorgliga erfarenheter göras på grund af det oförstånd med hvilket kaster, formbräden och regaler tillverkas och försäljas Kaster som äro dåligt hopkomna och af otillräckligt.';
  var artists = <int, Artist>{};
  Artist getArtist(int id) {
    return artists[id] ?? nullArtist;
  }

  void setArtist(int id, Artist artist) {
    artists[id] = artist;
  }

  List<Artist> getAllArtists() {
    List<Artist> allArtists = [];
    for (int i = 1; i <= 28; i++) {
      allArtists.add(artists[i] ?? nullArtist);
    }
    return allArtists;
  }

  void updateArtist(int id, Artist artist) {
    artists[id] = artist;
    notifyListeners();
  }
}

class Rule {
  Rule(this._name, this._desc, this._category, this._reward);
  final String _name;
  final String _desc;
  final String _category;
  final int _reward;
  
  getName() => _name;
  getDesc() => _desc;
  getCategory() => _category;
  getReward() => _reward;
}

class RuleList extends ChangeNotifier {
  final nullRule = Rule('', '', '', 0);
  var rules = <int, Rule>{};
  Rule getRule(int id) {
    return rules[id] ?? nullRule;
  }

  void setRule(int id, Rule rule) {
    rules[id] = rule;
  }

  Iterable<Rule> getAllRules() {
    //List<Rule> allRules = [];
    //for (int i = 1; i <= rules.length; i++) {
    //  allRules.add(rules[i] ?? nullRule);
    //}
    //return allRules;
    return rules.values;
  }

  void updateRule(int id, Rule rule) {
    rules[id] = rule;
    notifyListeners();
  }
}

class Event {
  Event(this._artist, this._rule, this._comment);
  final int _artist;
  final int _rule;
  var _comment;
  getArtist() => _artist;
  getRule() => _rule;
  getComment() => _comment;
}

class EventList extends ChangeNotifier {
  final nullEvent = Event(0, 0, '');
  var events = <int, Event>{};
  Event getEvent(int id) {
    return events[id] ?? nullEvent;
  }

  void setEvent(int id, Event event) {
    events[id] = event;
  }

  List<Event> getAllEvents() {
    List<Event> allEvents = [];
    for (int i = 1; i <= events.length; i++) {
      allEvents.add(events[i] ?? nullEvent);
    }
    return allEvents;
  }

  void updateEvent(int id, Event event) {
    events[id] = event;
    notifyListeners();
  }
}

class Team extends ChangeNotifier {
  final _team = List<int>.filled(5, 0);
  void setArtist(position, id) {
    for (int i = 0; i < _team.length; i++) {
      if (_team[i] == id) {
        _team[i] = 0;
      }
    }
    _team[position] = id;
  }

  void updateArtist(position, id) {
    for (int i = 0; i < _team.length; i++) {
      if (_team[i] == id) {
        _team[i] = 0;
      }
    }
    _team[position] = id;
    notifyListeners();
  }

  int getArtistId(int position) {
    return _team[position];
  }

  UnmodifiableListView getTeamIds() {
    return UnmodifiableListView(_team);
  }
}

class Fantamello extends StatelessWidget {
  const Fantamello({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RuleList(),
        ),
        ChangeNotifierProvider(
          create: (context) => EventList(),
        ),
        ChangeNotifierProvider(
          create: (context) => ArtistList(),
        ),
        ChangeNotifierProvider(
          create: (context) => Team(),
        )
      ],
      child: MaterialApp(
        title: 'Fantamello',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (_) => const SplashPage(),
          '/login': (_) => const LoginPage(),
          '/account': (_) => const AccountPage(),
          '/teampage': (_) => const TeamPage(),
        },
      ),
    );
  }
}
