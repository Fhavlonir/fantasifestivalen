import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../artistpicker/artistpicker.dart';
import '../artistpage/artistpage.dart';
import '../../app.dart';

class ArtistBox extends StatelessWidget {
  final int _position;
  final bool _editable;
  const ArtistBox(this._position, this._editable, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ArtistList>(builder: (context, artists, child) {
      return Consumer<Team>(
        builder: (context, team, child) {
          int id = team.getArtistId(_position);
          Artist _artist = artists.getArtist(id);
          int _cost = _artist.getCost();
          return TextButton(
              child: SizedBox(
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_artist.getName()),
                    Container(
                      constraints:
                          const BoxConstraints(minHeight: 100, minWidth: 100),
                      child: Stack(
                        children: [
                          Container(
                            constraints: const BoxConstraints(
                                minHeight: 100, minWidth: 100),
                            child: ColoredBox(
                              color: Colors.grey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '+',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //Hero(tag: id,
                            //child: 
                            Container(
                              constraints: const BoxConstraints(
                                  minHeight: 100, minWidth: 100, maxHeight: 100, maxWidth: 100),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(_artist.getImgUrl()),
                                ),
                              ),
                            ),
                          //),
                        ],
                      ),
                    ),
                    Text(
                      'Kostnad: $_cost',
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
              onPressed: () {
                if (_editable) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ArtistPicker(_position)),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ArtistPage(_position, id, _editable)),
                  );
                }
              });
        },
      );
    });
  }
}
