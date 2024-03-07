import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'dart:async';

import 'artistbox.dart';
import '../login/account_page.dart';
import '../rulespage/rulespage.dart';
import '../eventspage/eventspage.dart';
import '../aboutpage/aboutpage.dart';
import '../leaderboardspage/leaderboardspage.dart';
import '../../app.dart';
import '../../utils/eventfeed.dart';
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
  int _totalCost = 0;
  Team team = Team([0, 0, 0, 0, 0]);
  bool _updatedTeam = false;
  bool _editable = true;
  bool _boxDismissed = false;

  Future<void> _updateCost({required bool refresh}) async {
    if (_editable) {
      List<Artist?> artists = [];
      List<Future<Artist?>> futures = [];
      for (int id in team.getTeamIds()) {
        futures.add(isar.artists.get(id));
      }
      artists = await Future.wait(futures);
      int cost = 0;
      for (Artist? a in artists) {
        cost += a?.cost.toInt() ?? 0;
      }
      refresh
          ? setState(() {
              _totalCost = cost;
            })
          : _totalCost = cost;
    }
  }

  Future<void> _updateScore() async {
    if (!_editable) {
      int result = 0;
      List<Event> allEvents = [];
      List<Future> loadAllEvents = [];
      for (Event e in await isar.events.where().findAll()) {
        allEvents.add(e);
        loadAllEvents.add(e.artist.load());
      }
      await Future.wait(loadAllEvents);
      List<Event> filteredEvents = [];
      List<Future> loadFilteredEvents = [];
      for (Event e in allEvents) {
        if (team.getTeamIds()?.contains(e.artist.value?.id) ?? false) {
          filteredEvents.add(e);
          loadFilteredEvents.add(e.rule.load());
        }
      }
      await Future.wait(loadFilteredEvents);
      //for (Event e in artist?.events??[]) { //Someday, when Isar is patched...
      for (Event e in filteredEvents) {
        result += e.rule.value?.reward ?? 0;
      }
      _pointsTotal = 100 + result - _totalCost;
    }
  }

  Future<bool> _updateTeam() async {
    if (!_updatedTeam) {
      try {
        final teamResponse = await supabase
            .from('teams')
            .select('team_ids, team_name')
            .execute();
        final teamData = teamResponse.data;
        if (teamData != null) {
          List<int> newteam = [];
          if (teamData.length > 0) {
            for (int i = 0; i < 5; i++) {
              newteam.add(teamData[0]['team_ids'][i].toInt());
            }
            setState(() {
              _teamName = teamData[0]['team_name'];
              _editable = false;
              team = Team(newteam);
            });
          }
        }
      } catch (error) {
        context.showErrorSnackBar(
            message: 'Ett oväntat fel uppstod när laget uppdaterades: $error');
      }
      _updatedTeam = true;
    }
    return Future.value(true);
  }

  Future<bool> _updateAll() async {
    await Future.wait(<Future>[
      updateArtists(),
      updateRules(),
    ]);
    await Future.wait(<Future>[
      updateEvents(),
      _updateTeam(),
      _updateScore(),
      _updateCost(refresh: false),
    ]);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _updateAll(),
        builder: (
          context,
          AsyncSnapshot<bool> snapshot,
        ) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Fantasifestivalen"),
                  actions: <Widget>[
                    TextButton(
                        style: TextButton.styleFrom(
                            //primary: Colors.white,
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () {},
                        child: _editable
                            ? Text(
                                "Mellocash: $_cash",
                                style: Theme.of(context).textTheme.headline6,
                              )
                            : Text(
                                "Poängsumma: $_pointsTotal",
                                style: Theme.of(context).textTheme.headline6,
                              ))
                  ],
                ),
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        child: Container(),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/fantasifestivalen_256.png')),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      ListTile(
                          title: const Text('Regler'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RulesPage()));
                          }),
                      ListTile(
                          title: const Text('Händelser'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EventsPage()));
                          }),
                      ListTile(
                          title: const Text('Topplista'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LeaderboardsPage()));
                          }),
                      ListTile(
                          title: const Text('Om appen'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AboutPage()));
                          }),
                      ListTile(
                          title: const Text('Konto'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AccountPage()));
                          }),
                    ],
                  ),
                ),
                body: Center(
                    child: Stack(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                              : Text(
                                  _teamName,
                                  style: Theme.of(context).textTheme.headline3,
                                )),
                      FittedBox(
                          child: Column(children: [
                        Row(
                          children: [
                            ArtistBox(0, team, _editable, () {
                              _updateCost(refresh: true);
                            }),
                            ArtistBox(1, team, _editable, () {
                              _updateCost(refresh: true);
                            }),
                            ArtistBox(2, team, _editable, () {
                              _updateCost(refresh: true);
                            }),
                          ],
                        ),
                        Row(
                          children: [
                            ArtistBox(3, team, _editable, () {
                              _updateCost(refresh: true);
                            }),
                            ArtistBox(4, team, _editable, () {
                              _updateCost(refresh: true);
                            }),
                          ],
                        ),
                      ])),
                      _editable
                          ? Column(children: [
                              Text(
                                "Sätt samman ett lag av fem artister för högst 100 Mellocash!",
                                style: Theme.of(context).textTheme.headline6,
                                textAlign: TextAlign.center,
                              ),
                              Text("Total kostnad: $_totalCost",
                                  style: (_totalCost > _cash)
                                      ? const TextStyle(color: Colors.red)
                                      : const TextStyle())
                            ])
                          : Card(
                              elevation: 20,
                              child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth: 500.0, maxHeight: 250.0),
                                  child:
                                      EventFeed(team.getTeamIds().toList()))),
                    ],
                  ),
                  (_editable && !_boxDismissed)
                      ? AlertDialog(
                          title: const Text('Jag måste be om ursäkt'),
                          content: const SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(
                                    'Häromdagen fick jag ett mejl som beskrev en bugg, samt en händelse som jag missat lägga in. När jag försökte fixa buggen råkade jag göra ett fatalt misstag som gjorde att alla lagen raderades.'),
                                Text('Fantasifestivalen är ett projekt jag gör på min fritid, och har noll budget. Därför betalade jag inte företaget som tillhandahåller databasservern för regelbundna backups, och i min oförsiktighet hade jag inte heller gjort några manuella backups.'),
                                Text(
                                    'Därför måste ni nu tyvärr återskapa era lag. Jag är väldigt ledsen för detta, och jag ska se till att göra regelbundna säkerhetskopior nästa år.'),
                                Text(
                                    '/Philip'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                setState(() {
                                  _boxDismissed = true;
                                });
                                //Navigator.of(context).pop();
                              },
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                ])),
                floatingActionButton: ValueListenableBuilder(
                    valueListenable: _nameEmptyNotifier,
                    builder: (context, bool nameEmpty, child) {
                      if (_editable) {
                        if (!nameEmpty &&
                            _totalCost <= _cash &&
                            !team.getTeamIds().contains(0)) {
                          return FloatingActionButton(
                            tooltip: 'Godkänn',
                            onPressed: () async {
                              final response =
                                  await supabase.from('teams').insert([
                                {
                                  'team_ids': team.getTeamIds(),
                                  'team_name': _teamName,
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
                    }));
          }
        });
  }
}
