import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../app.dart';
import '../../utils/constants.dart';
import '../../utils/eventfeed.dart';

class ArtistPage extends StatelessWidget {
  final bool _editable;
  final Artist _artist;
  const ArtistPage(this._artist, this._editable, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _cost = _artist.cost;
    int _heat = _artist.heat;
    int _number = _artist.number;
    return Scaffold(
      appBar: AppBar(
        title: Text(_artist.name),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, false);
          return false;
        },
        child: Center( 
          child: Container( 
          constraints: BoxConstraints(maxWidth: 700),
          child: ListView( children: [
	    Stack( children:[
              Center(child: Padding(padding: EdgeInsets.all(48.0), child: const Image(image: const AssetImage('assets/images/fantasifestivalen_512.png')))),
              Hero(tag: _artist.id,
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 500),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(_artist.imgurl),
                      alignment: Alignment(0,-0.5),
                    ),
                  ),
                ),
              ),
	      ]),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  _artist.imgcred,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  _artist.name,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  _artist.song,
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
                child: Text(_artist.desc),
              ),
              SizedBox(
                height: 48,
              ),
              Center(child:SizedBox(
                width: 600.0, 
                height: 250.0,
                child: Card(
                  elevation: 20,
                  child: EventFeed([_artist.id]),
                  )
                )
              ),
              SizedBox(
                height: 48,
              )
            ],
          )
        )
      ),
      ),
      floatingActionButton: _editable
        ? FloatingActionButton(
          onPressed: () {
            Navigator.pop(context, true);//of(context).popUntil((route) => route.isFirst);
          },
          tooltip: 'Godkänn',
          child: const Icon(Icons.check),
        )
        : null,
    );
  }
}
