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
    return Consumer4<Team, ArtistList, RuleList, EventList>(builder: (context, team, artists, rules, events, child) {
      int id = team.getArtistId(_position);
      int _points = 0;
      Artist _artist = artists.getArtist(id);
      int _cost = _artist.getCost();
      if (!_editable){
        for (Event event in events.getAllEvents()){
          if (event.getArtist() == id){
            _points += rules.getRule(event.getRule()).getReward();
          }
        }
      }
      return TextButton(
          child: Container(
            constraints: BoxConstraints(maxWidth: 150, maxHeight: 150),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 32,
                    child: Column(children: [
                      Expanded(child: Container()),
                      Text(_artist.getName(),
                        textAlign: TextAlign.center,
                      ),
                    ])
                  ),
                  Expanded(
                    child: AspectRatio(
                    aspectRatio: 1.0,
                      child: Stack(
                        children: [
                          ColoredBox(
                            color: Colors.grey,
                            child: Center(
                              child: Text(
                                  '+',
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.headline2,
                                ),
                            ),
                          ),
                          Container(
                            child: id==0? null:
                              Hero( tag: id,
                                child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(_artist.getImgUrl()),
                                  ),
                                ),
                              ),
                            )
                          ),
                        ],
                      )
                    )
                  ),
                  SizedBox(
                    height: 16,
                    child: _editable? Text(
                      'Kostnad: $_cost',
                      style: Theme.of(context).textTheme.caption,
                    ) : Text(
                      'Poäng: $_points',
                      style: Theme.of(context).textTheme.caption,
                    )
                  )
                ],
              )
            )
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
          }
        );
      },
    );
  }
}
