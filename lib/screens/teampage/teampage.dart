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
  Team team = Team([0,0,0,0,0]);
  bool _updatedArtists = false;
  bool _updatedRules = false;
  bool _updatedTeam = false;
  bool _editable = true;
  Timer? shorttimer;
  DateTime _artistsLastUpdated=DateTime.fromMillisecondsSinceEpoch(0);

  @override
  void initState() {
    super.initState();
  }
  
  Future<void> _updateScore() async {
    if(!_editable) {
      int result = 0;
      List<Event> allEvents = [];
      List<Future> loadAllEvents = [];
      for (Event e in await isar.events.where().findAll()){
        allEvents.add(e);
        loadAllEvents.add(e.artist.load());
      }
      await Future.wait(loadAllEvents);
      List<Event> filteredEvents = [];
      List<Future> loadFilteredEvents = [];
      for (Event e in allEvents){
        if (team.getTeamIds()?.contains(e.artist.value?.id)??false) {
          filteredEvents.add(e);
          loadFilteredEvents.add(e.rule.load());
        }
      }
      await Future.wait(loadFilteredEvents);
      //for (Event e in artist?.events??[]) { //Someday, when Isar is patched...
      for (Event e in filteredEvents) {
        result += e.rule.value?.reward??0;
      };
      _pointsTotal = 100+result-_totalCost;
    }
  }

  Future<bool> _updateEvents() async {
    //Delete old events (pre-latest new years day):
    await isar.writeTxn((isar) async {
      final List<Event> oldEvents = await isar.events.where().timestampLessThan(DateTime.utc(DateTime.now().year,1,1)).findAll();
      for (int i = 0; i < oldEvents.length; i++) {
        final Event e = oldEvents[i];
        isar.events.delete(e.id);
      }
    });
    try {
      Event? latest = await isar.events.where().sortByTimestampDesc().findFirst();
      late final eventResponse;
      if(latest!=null){
        eventResponse = await supabase
          .from('events')
          .select(
              'id, created_at, artist, rule, comment')
          .gt('created_at', latest.timestamp.toUtc().add(const Duration(seconds: 1)))
          .execute();
      } else {
        eventResponse = await supabase
          .from('events')
          .select(
              'id, created_at, artist, rule, comment')
          .execute();
      }
      final eventData = eventResponse.data;
      if (eventData != null) {
        await isar.writeTxn((isar) async {
          for (int i = 0; i < eventData.length; i++) {
            Event event = Event(
              eventData[i]['id'],
              eventData[i]['comment']??'',
              DateTime.parse(eventData[i]['created_at']),
            );
            await isar.events.put( event );
            event.artist.value = await isar.artists.get(eventData[i]['artist'].toInt());
            await event.artist.save();
            event.rule.value = await isar.rules.get(eventData[i]['rule'].toInt());
            await event.rule.save();
          }
        });
        _updateScore();
      }
    } catch (error) {
      context.showErrorSnackBar(message: 'Ett oväntat fel uppstod: $error');
    }
    return Future.value(true);
  }

  Future<bool> _updateRules() async {
    if (!_updatedRules) {
      try {
        Rule? latest = await isar.rules.where().sortByTimestampDesc().findFirst();
        late final ruleResponse;
        if(latest!=null){
          ruleResponse = await supabase
            .from('rules')
            .select(
                'id, created_at, name, desc, category, reward')
            .gte('created_at', latest.timestamp)
            .execute();
        } else {
          ruleResponse = await supabase
            .from('rules')
            .select(
                'id, created_at, name, desc, category, reward')
            .execute();
        }
        final ruleData = ruleResponse.data;
        if (ruleData != null) {
          await isar.writeTxn((isar) async {
            for (int i = 0; i < ruleData.length; i++) {
              await isar.rules.put(
                Rule(
                  ruleData[i]['id'].toInt(),
                  ruleData[i]['name'].toString(),
                  ruleData[i]['desc'] ?? '',
                  ruleData[i]['category'].toString(),
                  ruleData[i]['reward'].toInt(),
                  DateTime.parse(ruleData[i]['created_at']),
                )
              );
            }
          });
        }
      } catch (error) {
        context.showErrorSnackBar(message: 'Ett oväntat fel uppstod: $error');
      }
      _updatedRules = true;
    }
    return Future.value(true);
  }
  Future<bool> _updateArtists() async {
    if (DateTime.now().difference(_artistsLastUpdated).inMinutes>60) {
      try {
        Artist? latest = await isar.artists.where().sortByTimestampDesc().findFirst();
        late final artistResponse;
        if(latest!=null){
          artistResponse = await supabase
            .from('artists')
            .select(
                'id, created_at, name, song, heat, start_number, cost, description, image_credits, image_url')
            .gte('created_at', latest.timestamp)
            .execute();
        } else {
         artistResponse = await supabase
            .from('artists')
            .select(
                'id, created_at, name, song, heat, start_number, cost, description, image_credits, image_url')
            .execute();
        }
        final artistData = artistResponse.data;
        if (artistData != null) {
          await isar.writeTxn((isar) async {
            for (int i = 0; i < artistData.length; i++) {
              await isar.artists.put(
                Artist(
                  artistData[i]['id'].toInt(),
                  artistData[i]['name'].toString(),
                  artistData[i]['song'].toString(),
                  artistData[i]['cost'].toInt(),
                  artistData[i]['heat'].toInt(),
                  artistData[i]['start_number'].toInt(),
                  artistData[i]['description'],
                  artistData[i]['image_credits']?.toString()??'',
                  artistData[i]['image_url']?.toString()??'',
                  DateTime.parse(artistData[i]['created_at']),
                )
              );
            }
          });
        }
      } catch (error) {
        context.showErrorSnackBar(message: 'Ett oväntat fel uppstod: $error');
      }
      _artistsLastUpdated = DateTime.now();
    }
    return Future.value(true);
  }

  Future<void> _updateCost({required bool refresh}) async {
    List<Artist?> artists = [];
    List<Future<Artist?>> futures = [];
    for (int id in team.getTeamIds()) {
      futures.add(isar.artists.get(id));
    }
    artists = await Future.wait(futures);
    int cost = 0;
    for (Artist? a in artists) {
      cost += a?.cost.toInt()??0;
    }
    refresh?setState(() {_totalCost = cost;}):
    _totalCost = cost;
  }

  Future<bool> _updateTeam() async {
    if (!_updatedTeam) {
      try {
        final teamResponse = await supabase.from('teams')
          .select('team_ids, team_name')
          .execute();
        final teamData = teamResponse.data;
        if (teamData != null) {
          List<int> newteam = [];
          if (teamData.length>0){
            for(int i=0; i<5; i++){
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
        context.showErrorSnackBar(message: 'Ett oväntat fel uppstod när laget uppdaterades: $error');
      }
      _updatedTeam = true;
    }
    return Future.value(true);
  }
  Future<bool> _updateAll() async {
    await Future.wait(<Future>[
      _updateArtists(),
      _updateRules(),
    ]);
    await Future.wait(<Future>[
      _updateTeam(),
      _updateEvents(),
      _updateScore(),
      _updateCost(refresh: false),
    ]);
    shorttimer = Timer.periodic(Duration(seconds: 10), (Timer t) => _updateEvents());
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _updateAll() ,
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
                    onPressed: () {
                    },
                    child: _editable? 
                      Text("Mellocash: $_cash",
                              style: Theme.of(context).textTheme.headline6,):
                      Text("Poängsumma: $_pointsTotal", 
                              style: Theme.of(context).textTheme.headline6,)
                  )
                ],
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      child: Container(),
                      decoration: BoxDecoration(
                        image: const DecorationImage(image: AssetImage('assets/images/fantasifestivalen_256.png')),
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
                      title: const Text('Topplista'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LeaderboardsPage()));
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
              body: Center(
                child: Column(
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
                          : Text(_teamName,
                              style: Theme.of(context).textTheme.headline3,)
                    ),
                      FittedBox(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ArtistBox(0, team, _editable, () {_updateCost(refresh: true);}),
                                ArtistBox(1, team, _editable, () {_updateCost(refresh: true);}),
                                ArtistBox(2, team, _editable, () {_updateCost(refresh: true);}),
                              ],
                            ),
                            Row(
                              children:[
                                ArtistBox(3, team, _editable, () {_updateCost(refresh: true);}),
                                ArtistBox(4, team, _editable, () {_updateCost(refresh: true);}),
                              ],
                            ),
                          ]
                        )
                      ),
                      _editable? Column(
                        children: [
                          Text(
                            "Sätt samman ett lag av fem artister för högst 100 Mellocash!",
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,),
                          Text("Total kostnad: $_totalCost",
                            style: (_totalCost > _cash)
                              ? const TextStyle(color: Colors.red)
                              : const TextStyle())
                        ]
                      ) : Card(
                        elevation: 20,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 500.0, maxHeight: 250.0),
                          child: EventFeed(team.getTeamIds().toList())
                        )
                      ),
                  ],
                )
              ),
              floatingActionButton:
                ValueListenableBuilder(
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
                  }
              )
            );
          }
        }
    );
  }
}
