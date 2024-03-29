import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:isar/isar.dart';

import '../artistpage/artistpage.dart';
import '../../app.dart';
import '../../utils/constants.dart';

Future<void> _spawnArtistPage(BuildContext context, Artist _artist) async {
  bool picked;
  picked = await Navigator.push(
          context,
          MaterialPageRoute<bool>(
              builder: (context) => ArtistPage(_artist, true))) ??
      false;
  if (picked) {
    Navigator.pop(context, _artist.id);
  }
}

class ArtistOption extends StatelessWidget {
  final int id;
  const ArtistOption(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Artist?>(
        future: isar.artists.get(id),
        builder: (BuildContext context, AsyncSnapshot<Artist?> snapshot) {
          Artist _artist = snapshot.data ??
              Artist(0, 'Laddar...', '', 0, 0, 0, '', '', '',
                  DateTime.fromMillisecondsSinceEpoch(0));

          return SizedBox(
            height: 300,
            child: TextButton(
              child: Container(
                  constraints: BoxConstraints(maxWidth: 500),
                  child: Stack(children: [
                    Center(
                        child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: const Image(
                                image: const AssetImage(
                                    'assets/images/fantasifestivalen_512.png')))),
                    Hero(
                      tag: _artist.id,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(_artist.imgurl),
                            alignment: Alignment(0, -0.75),
                          ),
                        ),
                        alignment: Alignment.bottomLeft,
                        child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                  Colors.pink.shade50.withAlpha(0),
                                  Colors.pink.shade50.withAlpha(0),
                                  Colors.pink.shade50
                                ])),
                            child: Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            child: Text(_artist.heat.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6),
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(_artist.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6),
                                          Text(_artist.cost.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4)
                                        ]),
                                  ],
                                ))),
                      ),
                    ),
                  ])),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(0))),
              onPressed: () {
                _spawnArtistPage(context, _artist);
              },
            ),
          );
        });
  }
}

class ArtistPicker extends StatelessWidget {
  const ArtistPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fantasifestivalen"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, 0);
          return false;
        },
        child: Container(
          child: Center(
            child: Container(
                child: ListView(
              children: List<int>.generate(30, (index) => index + 1,
                      growable: false) // TODO: De-hardcode number of artists
                  .map((id) => ArtistOption(id))
                  .toList(),
            )),
          ),
        ),
      ),
    );
  }
}
