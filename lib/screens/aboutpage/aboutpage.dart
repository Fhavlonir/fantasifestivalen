import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AboutPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Om appen'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Text('Hej!',
                  style: Theme.of(context).textTheme.headline1
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                constraints: BoxConstraints(maxWidth:200),
                child: ClipOval(
                  child: SizedBox.fromSize(     
                    size: Size.fromRadius(100), 
                    child: CachedNetworkImage(imageUrl: 'https://pbs.twimg.com/profile_images/1373325891384786946/IkVLOrwN_400x400.jpg'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                constraints: BoxConstraints(maxWidth: 400),
                child: Text(
                  'Jag hoppas du gillar appen! Jag som gjort den heter Philip Johansson, jag bor i Lund och pluggar på LTH.\nAppen är publicerad under licensen GNU Affero General Public License version 3.\nDen är byggd med hjälp av Flutter, hostad med hjälp av Github Pages och Supabase.\nBilderna kommer från Wikimedia Commons, oändliga tack till alla som bidragit med dessa, särskilt Jonatan Svensson Glad, AnnCatrin Blyckerts och Daniel Åhs Karlsson.'),
              )
            ]
          )]
        ),
      );
  }
}
