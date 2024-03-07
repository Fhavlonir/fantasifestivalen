import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:isar/isar.dart';
import 'dart:async';

import '../main.dart';
import '../app.dart';

final supabase = Supabase.instance.client;
late final Isar isar;
final Timer shorttimer =
    Timer.periodic(Duration(seconds: 10), (Timer t) => updateEvents());
bool updatedArtists = false;
bool updatedRules = false;
DateTime eventsLastUpdated = DateTime.fromMillisecondsSinceEpoch(0);
DateTime artistsLastUpdated = DateTime.fromMillisecondsSinceEpoch(0);

Future<bool> updateEvents({bool force = false}) async {
  if (DateTime.now().difference(eventsLastUpdated).inSeconds > 10 || force) {
    eventsLastUpdated = DateTime.now();
    //Delete old events (pre-latest new years day):
    await isar.writeTxn((isar) async {
      final List<Event> oldEvents = await isar.events
          .where()
          .timestampLessThan(DateTime.utc(DateTime.now().year, 1, 1))
          .findAll();
      for (int i = 0; i < oldEvents.length; i++) {
        final Event e = oldEvents[i];
        isar.events.delete(e.id);
      }
    });
    try {
      Event? latest =
          await isar.events.where().sortByTimestampDesc().findFirst();
      late final eventResponse;
      if (latest != null) {
        eventResponse = await supabase
            .from('events')
            .select('id, created_at, artist, rule, comment')
            .gt('created_at',
                latest.timestamp.toUtc().add(const Duration(seconds: 1)))
            .execute();
      } else {
        eventResponse = await supabase
            .from('events')
            .select('id, created_at, artist, rule, comment')
            .execute();
      }
      final eventData = eventResponse.data;
      if (eventData != null) {
        await isar.writeTxn((isar) async {
          for (int i = 0; i < eventData.length; i++) {
            Event event = Event(
              eventData[i]['id'],
              eventData[i]['comment'] ?? '',
              DateTime.parse(eventData[i]['created_at']),
            );
            await isar.events.put(event);
            event.artist.value =
                await isar.artists.get(eventData[i]['artist'].toInt());
            await event.artist.save();
            event.rule.value =
                await isar.rules.get(eventData[i]['rule'].toInt());
            await event.rule.save();
          }
        });
      }
    } catch (error) {
      print('Ett oväntat fel uppstod: $error');
    }
  }
  return Future.value(true);
}

Future<bool> updateRules() async {
  if (DateTime.now().difference(artistsLastUpdated).inMinutes > 60) {
    try {
      Rule? latest = await isar.rules.where().sortByTimestampDesc().findFirst();
      late final ruleResponse;
      if (latest != null) {
        ruleResponse = await supabase
            .from('rules')
            .select('id, created_at, name, desc, category, reward')
            .gte('created_at', latest.timestamp)
            .execute();
      } else {
        ruleResponse = await supabase
            .from('rules')
            .select('id, created_at, name, desc, category, reward')
            .execute();
      }
      final ruleData = ruleResponse.data;
      if (ruleData != null) {
        await isar.writeTxn((isar) async {
          for (int i = 0; i < ruleData.length; i++) {
            await isar.rules.put(Rule(
              ruleData[i]['id'].toInt(),
              ruleData[i]['name'].toString(),
              ruleData[i]['desc'] ?? '',
              ruleData[i]['category'].toString(),
              ruleData[i]['reward'].toInt(),
              DateTime.parse(ruleData[i]['created_at']),
            ));
          }
        });
      }
    } catch (error) {
      print('Ett oväntat fel uppstod: $error');
    }
    updatedRules = true;
  }
  return Future.value(true);
}

Future<bool> updateArtists() async {
  if (DateTime.now().difference(artistsLastUpdated).inMinutes > 60) {
    try {
      Artist? latest =
          await isar.artists.where().sortByTimestampDesc().findFirst();
      late final artistResponse;
      if (latest != null) {
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
            await isar.artists.put(Artist(
              artistData[i]['id'].toInt(),
              artistData[i]['name'].toString(),
              artistData[i]['song'].toString(),
              artistData[i]['cost'].toInt(),
              artistData[i]['heat'].toInt(),
              artistData[i]['start_number'].toInt(),
              artistData[i]['description'],
              artistData[i]['image_credits']?.toString() ?? '',
              artistData[i]['image_url']?.toString() ?? '',
              DateTime.parse(artistData[i]['created_at']),
            ));
          }
        });
      }
    } catch (error) {
      print('Ett oväntat fel uppstod: $error');
    }
    artistsLastUpdated = DateTime.now();
  }
  artistsLastUpdated = DateTime.now();
  return Future.value(true);
}

extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.pink,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}
