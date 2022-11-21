import 'package:fantamello/components/auth_required_state.dart';
import 'package:fantamello/screens/login/account_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'artistbox.dart';
import '../../app.dart';
import '../../utils/constants.dart';
import '../login/account_page.dart';
import '../../components/auth_required_state.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  AuthRequiredState<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends AuthRequiredState<TeamPage> {
  final ValueNotifier<bool> _nameEmptyNotifier = ValueNotifier(true);
  int _cash = 100;
  String _teamName = "";
  int _total = 0;
  List _teamIds = [];
  bool _updatedArtists = false;
  bool _updatedTeam = false;
  bool _editable = true;

  Future<bool> _updateArtists() async {
    if (!_updatedArtists) {
      final artistResponse = await supabase
          .from('artists')
          .select(
              'id, name, song, heat, start_number, cost, image, description')
          .execute();
      final artistError = artistResponse.error;
      if (artistError != null && artistResponse.status != 406) {
        context.showErrorSnackBar(message: artistError.message);
      }
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
                  artistData[i]['description'] ?? ArtistList.dummy));
        }
      }
      _updatedArtists = true;
    }
    return Future.value(true);
  }

  Future<bool> _updateTeam() async {
    if (!_updatedTeam) {
      final teamResponse = await supabase
          .from('teams')
          .select('team_ids, team_name, cash')
          .execute();
      final teamError = teamResponse.error;
      if (teamError != null && teamResponse.status != 406) {
        context.showErrorSnackBar(message: teamError.message);
      }
      final teamData = teamResponse.data;
      if (teamData != null) {
        _teamIds = teamData[0]['team_ids'];
        _teamName = teamData[0]['team_name'];
        _cash = teamData[0]['cash'];
        print("_cash: $_cash");
        _editable = false;
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AccountPage()));
                    },
                    child: Text("Mellocash: $_cash"),
                  )
                ],
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40.0),
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
                    print("editable: $_editable");
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
                            (id) => _total += artists.getArtist(id).cost);
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
                              print(response.toJson().toString());
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
