import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../artistpage/artistpage.dart';
import '../../app.dart';

class ArtistOption extends StatelessWidget {
  final int id;
  final int position;
  const ArtistOption(this.position, this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ArtistList>(builder: (context, artists, child) {
      var _artist = artists.getArtist(id);
      var _cost = _artist.getCost();
      return SizedBox(
        height: 300,
        child: TextButton(
          child: Stack(children: [
            Hero(
              tag: id,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: const FractionalOffset(0.5, 0.1),
                    image: CachedNetworkImageProvider(_artist.getImgUrl()),
                  ),
                ),
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withAlpha(0),
                            Colors.white38,
                            Colors.white38
                      ])),
                  child: Container(
                    margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_artist.getName(),
                              style: Theme.of(context).textTheme.headline6),
                          Text(_cost.toString(),
                              style: Theme.of(context).textTheme.headline4)
                  ])),
                ),
              ),
            ),
          ]),
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(0))),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArtistPage(position, id, true)));
          },
        ),
      );
    });
  }
}

class ArtistPicker extends StatelessWidget {
  final int position;
  const ArtistPicker(this.position, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ArtistList>(builder: (context, artists, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Fantasifestivalen"),
        ),
        body: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth:600),
                child: ListView(
                    children:
                        List<int>.generate(28, (index) => index + 1, growable: false)
                            .map((id) => ArtistOption(position, id))
                            .toList(),
                  )
              ),
            ],
          ),
        ),
      );
    });
  }
}
