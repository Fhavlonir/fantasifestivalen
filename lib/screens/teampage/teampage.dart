import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'artistbox.dart';
import '../login/account_page.dart';
import '../rulespage/rulespage.dart';
import '../eventspage/eventspage.dart';
import '../aboutpage/aboutpage.dart';
import '../../app.dart';
import '../../utils/constants.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  final ValueNotifier<bool> _nameEmptyNotifier = ValueNotifier(true);
  int _cash = 100;
  int _pointsTotal = 0;
  String _teamName = "";
  int _total = 0;
  List _teamIds = [];
  bool _updatedArtists = false;
  bool _updatedRules = false;
  bool _updatedEvents = false;
  bool _updatedTeam = false;
  bool _editable = true;

  Future<bool> _updateEvents() async {
    if (!_updatedEvents) {
      try {
        final eventResponse = await supabase
            .from('events')
            .select(
                'id, artist, rule, comment')
            .execute();
        final eventData = eventResponse.data;
        if (eventData != null) {
          for (int i = 0; i < eventData.length; i++) {
            Provider.of<EventList>(context, listen: false).setEvent(
              eventData[i]['id'].toInt(),
              Event(
                  eventData[i]['artist'].toInt(),
                  eventData[i]['rule'].toInt(),
                  eventData[i]['comment'],
              )
            );
          }
        }
      } catch (error) {
        context.showErrorSnackBar(message: 'Ett oväntat fel uppstod');
      }
        _updatedEvents = true;
      }
    return Future.value(true);
  }
  Future<bool> _updateRules() async {
    if (!_updatedRules) {
      try {
        final ruleResponse = await supabase
            .from('rules')
            .select(
                'id, name, desc, category, reward')
            .execute();
        final ruleData = ruleResponse.data;
        if (ruleData != null) {
          for (int i = 0; i < ruleData.length; i++) {
            Provider.of<RuleList>(context, listen: false).setRule(
              ruleData[i]['id'].toInt(),
              Rule(
                  ruleData[i]['name'].toString(),
                  ruleData[i]['desc'] ?? '',
                  ruleData[i]['category'].toString(),
                  ruleData[i]['reward'].toInt(),
              )
            );
          }
        }
      } catch (error) {
        context.showErrorSnackBar(message: 'Ett oväntat fel uppstod');
      }
      _updatedRules = true;
    }
    return Future.value(true);
  }
  Future<bool> _updateArtists() async {
    if (!_updatedArtists) {
      try {
        final artistResponse = await supabase
            .from('artists')
            .select(
                'id, name, song, heat, start_number, cost, image, description, image_credits, image_url')
            .execute();
        final artistData = artistResponse.data;
        if (artistData != null) {
          for (int i = 0; i < artistData.length; i++) {
            Provider.of<ArtistList>(context, listen: false).setArtist(
                artistData[i]['id'].toInt(),
                Artist(
                    artistData[i]['name'].toString(),
                    artistData[i]['song'].toString(),
                    artistData[i]['cost'].toInt(),
                    artistData[i]['heat'].toInt(),
                    artistData[i]['start_number'].toInt(),
                    "assets/images/" + artistData[i]['image'].toString(),
                    artistData[i]['description'] ?? ArtistList.dummy,
                    artistData[i]['image_credits'].toString(),
                    artistData[i]['image_url'].toString()));
          }
        }
      } catch (error) {
        context.showErrorSnackBar(message: 'Ett oväntat fel uppstod');
      }
      _updatedArtists = true;
    }
    return Future.value(true);
  }

  Future<bool> _updateTeam() async {
    if (!_updatedTeam) {
      try {
        final teamResponse = await supabase
            .from('teams')
            .select('team_ids, team_name, cash')
            .execute();
        final teamData = teamResponse.data;
        if (teamData != null) {
          _teamIds = teamData[0]['team_ids'];
          _teamName = teamData[0]['team_name'];
          _cash = teamData[0]['cash'];
          _editable = false;
          _pointsTotal = 0;
        }
      } catch (error) {
        context.showErrorSnackBar(message: 'Ett oväntat fel uppstod');
      }
      _updatedTeam = true;
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          _updateTeam(),
          _updateArtists(),
          _updateRules(),
          _updateEvents(),
        ]),
        builder: (
          context,
          AsyncSnapshot<List<bool>> snapshot,
        ) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Fantamello"),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20)),
                    onPressed: () {
                    },
                    child: _editable? Text("Mellocash: $_cash"):Text("Poängsumma: $_pointsTotal"),
                  )
                ],
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Text('Fantamello'),
                    ),
                    ListTile(
                      title: const Text('Regler'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RulesPage()));
                      }
                    ),
                    ListTile(
                      title: const Text('Händelser'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EventsPage()));
                      }
                    ),
                    ListTile(
                      title: const Text('Om appen'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutPage()));
                      }
                    ),
                    ListTile(
                      title: const Text('Konto'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AccountPage()));
                      }
                    ),
                  ],
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: _editable
                        ? TextField(
                            decoration: const InputDecoration(
                              labelText: "Namnge ditt lag",
                            ),
                            onChanged: (String value) {
                              _teamName = value;
                              _nameEmptyNotifier.value = (value == "");
                            },
                          )
                        : Text(_teamName,
                            style: Theme.of(context).textTheme.headline3),
                  ),
                  Center(child: Consumer<Team>(builder: (context, team, child) {
                    if (!_editable) {
                      for (int i = 0; i < 5; i++) {
                        team.setArtist(i, _teamIds[i]);
                      }
                    }
                    return Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      spacing: 20.0,
                      runSpacing: 30.0,
                      children: [
                        ArtistBox(0, _editable),
                        ArtistBox(1, _editable),
                        ArtistBox(2, _editable),
                        ArtistBox(3, _editable),
                        ArtistBox(4, _editable),
                      ],
                    );
                  })),
                  Consumer<Team>(builder: (context, team, child) {
                    if (_editable) {
                      return Consumer<ArtistList>(
                          builder: (context, artists, child) {
                        _total = 0;
                        team.getTeamIds().forEach(
                            (id) => _total += artists.getArtist(id).getCost() as int);
                        return Text("Total kostnad: $_total",
                            style: (_total > _cash)
                                ? const TextStyle(color: Colors.red)
                                : const TextStyle());
                      });
                    } else {
                      return const SizedBox.shrink();
                    }
                  })
                ],
              ),
              floatingActionButton:
                Consumer<Team>(builder: (context, team, child) {
                  return ValueListenableBuilder(
                      valueListenable: _nameEmptyNotifier,
                      builder: (context, bool nameEmpty, child) {
                        if (_editable) {
                          if (!nameEmpty &&
                              _total <= _cash &&
                              !team.getTeamIds().contains(0)) {
                            return FloatingActionButton(
                              tooltip: 'Godkänn',
                              onPressed: () async {
                                final response =
                                    await supabase.from('teams').insert([
                                  {
                                    'team_ids': team.getTeamIds(),
                                    'team_name': _teamName,
                                    'cash': _cash -
                                        _total, //TODO: calculate server side
                                  }
                                ]).execute();
                                setState(() {
                                  _updatedTeam = false;
                                });
                              },
                              child: const Icon(Icons.check),
                            );
                          }
                          return const FloatingActionButton(
                              onPressed: null,
                              backgroundColor: Colors.grey,
                              child: Icon(Icons.close));
                        } else {
                          return const SizedBox.shrink();
                        }
                      });
              }),
            );
          }
        });
  }
}
