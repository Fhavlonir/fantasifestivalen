import 'package:flutter/material.dart';
import 'screens/teampage/teampage.dart';
import 'screens/login/account_page.dart';
import 'screens/login/login.dart';
import 'screens/login/splash_page.dart';
import 'package:provider/provider.dart';
import 'dart:collection';

class Artist {
  Artist(this.name, this.song, this.cost, this.heat, this.number, this._imgpath,
      this.desc);
  final String name;
  final String song;
  int cost;
  int heat;
  int number;
  final String _imgpath;
  getImg() => _imgpath + ".jpg";
  getThumb() => _imgpath + "_thumb.jpg";
  String desc;
}

class ArtistList extends ChangeNotifier {
  final nullArtist = Artist('Välj Artist', '', 0, 0, 0, "", "");
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
