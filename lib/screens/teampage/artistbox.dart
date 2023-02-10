import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:isar/isar.dart';

import '../artistpicker/artistpicker.dart';
import '../artistpage/artistpage.dart';
import '../../utils/constants.dart';
import '../../app.dart';

class ArtistBox extends StatefulWidget {
  final int position;
  final Team team;
  final bool editable;
  final VoidCallback updateBox;
  const ArtistBox(this.position, this.team, this.editable, this.updateBox, { super.key });

  @override
  State<ArtistBox> createState() => _ArtistBoxState(); 
} 

class _ArtistBoxState extends State<ArtistBox> {
  Artist? artist;
  int _points = 0;
  int? _cost;

  Future<void> updateBox() async {
    Artist? result = await isar.artists.get(widget.team.getArtistId(widget.position));
    artist = result;
    _cost = artist?.cost??0;
    if(!widget.editable){
      await updateScore();
    }
  }

  Future<void> updateScore() async {
    int score = 0;
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
      if (e.artist.value?.id == artist?.id) {
        filteredEvents.add(e);
        loadFilteredEvents.add(e.rule.load());
      }
    }
    await Future.wait(loadFilteredEvents);
    
    //for (Event e in artist?.events??[]) { //Someday, when Isar is patched...
    for (Event e in filteredEvents){
      score += e.rule.value?.reward??0;
    };
    _points = score;
  }

  Future<void> _onPressed() async {
    if (widget.editable) {
      var id = await Navigator.push(
        context,
        MaterialPageRoute<int>(
          builder: (context) => ArtistPicker()
        ),
      );
      Artist? _artist = await isar.artists.get(id??0);
      widget.team.updateArtist(widget.position, id);
      widget.updateBox();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute<bool>(
          builder: (context) => ArtistPage(artist??Artist(0,'','',0,0,0,'','','',DateTime.now()), widget.editable)
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Team team = widget.team;
    bool editable = widget.editable;
    return FutureBuilder(
      future: Future.wait([updateBox()]),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) { 
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
                      Text(
                        artist?.name ?? "Välj artist",
                        textAlign: TextAlign.center,) 
                    ])
                  ),
                  Expanded(
                    child: AspectRatio(
                    aspectRatio: 1.0,
                      child: Stack(
                        children: [
                          ColoredBox(
                            color: Theme.of(context).splashColor,
                            child: Center(
                              child: Text(
                                  '+',
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.headline2,
                                ),
                            ),
                          ),
                          if ((artist?.imgurl??'') != '') Hero( tag: artist!.id,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(artist!.imgurl),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    )
                  ),
                  SizedBox(
                    height: 16,
                    child: editable? Text(
                      'Kostnad: '+(_cost?.toString()??'0'),
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
            _onPressed();
          }
        );
      }
    );
  }
}
