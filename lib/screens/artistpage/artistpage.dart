import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../app.dart';

class ArtistPage extends StatelessWidget {
  final int id;
  final int position;
  final bool _editable;
  const ArtistPage(this.position, this.id, this._editable, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Consumer<ArtistList>(builder: (context, artists, child) {
      Artist _artist = artists.getArtist(id);
      var _cost = _artist.getCost();
      var _heat = _artist.getHeat();
      var _number = _artist.getNumber();
      return Scaffold(
        appBar: AppBar(
          title: Text(_artist.getName()),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            Hero(tag: id,
              child: Container(
                constraints: const BoxConstraints(maxHeight: 500),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(_artist.getImgUrl())
                  ),
                ),
              ),
              
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                _artist.getImgCred(),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                _artist.getName(),
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                _artist.getSong(),
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Text(
                "Kostnad: $_cost",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Text(
                "Deltävling: $_heat",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Text(
                "Startnummer: $_number",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: Text(_artist.getDesc()),
            ),
          ],
        ),
        floatingActionButton: _editable
            ? FloatingActionButton(
                onPressed: () {
                  Provider.of<Team>(context, listen: false)
                      .updateArtist(position, id);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                tooltip: 'Godkänn',
                child: const Icon(Icons.check),
              )
            : null,
      );
    }));
  }
}
