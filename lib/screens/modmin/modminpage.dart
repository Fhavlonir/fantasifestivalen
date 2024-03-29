import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:isar/isar.dart';

import '../../utils/constants.dart';
import '../../app.dart';
import '../../utils/eventfeed.dart';

class ModminPage extends StatefulWidget {
  const ModminPage({super.key});

  @override
  State<ModminPage> createState() => _ModminState();
}

class _ModminState extends State<ModminPage> {
  final TextEditingController heatController = TextEditingController();
  final TextEditingController artistController = TextEditingController();
  final TextEditingController ruleController = TextEditingController();
  bool _artistsUpdated = false;
  bool _rulesUpdated = false;
  int chosenHeat = 1;
  int chosenArtist = 0;
  int chosenRule = 0;
  List<DropdownMenuEntry<int>> _artistEntries = [];
  List<DropdownMenuEntry<int>> _ruleEntries = [];

  Future<void> _updateArtists() async {
    List<DropdownMenuEntry<int>> _updatedArtists = [];
    if (chosenHeat < 6) {
      for (Artist a
          in await isar.artists.filter().heatEqualTo(chosenHeat).findAll()) {
        _updatedArtists.add(
          DropdownMenuEntry(value: a.id, label: a.name),
        );
      }
    } else if (chosenHeat == 6) {
      // Vidare till final? Utslagen?
      List<int> _excludedArtists = [];
      for (Event e in await isar.events.where().findAll()) {
        await e.rule.load();
        if ((e.rule.value?.id ?? 0) >= 13 && (e.rule.value?.id ?? 0) <= 16) {
          await e.artist.load();
          _excludedArtists.add(e.artist.value?.id ?? 0);
        }
      }
      for (Artist a in await isar.artists.where().findAll()) {
        if (!_excludedArtists.contains(a.id)) {
          _updatedArtists.add(
            DropdownMenuEntry(value: a.id, label: a.name),
          );
        }
      }
    } else if (chosenHeat == 7) {
      // Vidare till final?
      List<int> _includedArtists = [];
      for (Event e in await isar.events.where().findAll()) {
        await e.rule.load();
        if ((e.rule.value?.id ?? 0) == 13 ||
            (e.rule.value?.id ?? 0) == 14 ||
            (e.rule.value?.id ?? 0) == 17) {
          await e.artist.load();
          _includedArtists.add(e.artist.value?.id ?? 0);
        }
      }
      for (Artist a in await isar.artists.where().findAll()) {
        if (_includedArtists.contains(a.id)) {
          _updatedArtists.add(
            DropdownMenuEntry(value: a.id, label: a.name),
          );
        }
      }
    }
    _artistsUpdated = true;
    setState(() {
      _artistEntries = _updatedArtists;
    });
  }

  Future<void> _updateRules() async {
    List<DropdownMenuEntry<int>> _updatedRules = [];
    List<String> _excludedCategories = [];
    if (chosenHeat < 6) {
      _excludedCategories = ["Finalen", "Finalkval"];
    } else if (chosenHeat == 6) {
      _excludedCategories = ["Finalen", "Deltävling"];
    } else if (chosenHeat == 7) {
      _excludedCategories = ["Finalkval", "Deltävling"];
    }
    for (Rule r in await isar.rules.where().findAll()) {
      if (!_excludedCategories.contains(r.category)) {
        _updatedRules.add(
          DropdownMenuEntry(value: r.id, label: r.name),
        );
      }
    }
    _rulesUpdated = true;
    setState(() {
      _ruleEntries = _updatedRules;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.wait([
      !_artistsUpdated ? _updateArtists() : new Future<void>.value(),
      !_rulesUpdated ? _updateRules() : new Future<void>.value(),
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Modmin'),
      ),
      body: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const SizedBox(height: 18),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          DropdownMenu<int>(
              width: .4 * MediaQuery.of(context).size.width,
              initialSelection: 1,
              controller: heatController,
              requestFocusOnTap: true,
              label: const Text('Deltävling'),
              onSelected: (int? heat) {
                setState(() {
                  chosenHeat = heat ?? 1;
                  _artistsUpdated = false;
                  _rulesUpdated = false;
                });
              },
              dropdownMenuEntries: [
                DropdownMenuEntry(value: 1, label: '1'),
                DropdownMenuEntry(value: 2, label: '2'),
                DropdownMenuEntry(value: 3, label: '3'),
                DropdownMenuEntry(value: 4, label: '4'),
                DropdownMenuEntry(value: 5, label: '5'),
                DropdownMenuEntry(value: 6, label: 'Finalkval'),
                DropdownMenuEntry(value: 7, label: 'Final'),
              ]),
          const SizedBox(width: 18),
          DropdownMenu<int>(
            width: .4 * MediaQuery.of(context).size.width,
            initialSelection: 1,
            controller: artistController,
            requestFocusOnTap: true,
            label: const Text('Artist'),
            onSelected: (int? artist) {
              setState(() {
                chosenArtist = artist ?? 1;
              });
            },
            dropdownMenuEntries: _artistEntries ?? [],
          ),
        ]),
        const SizedBox(height: 18),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          DropdownMenu<int>(
            width: .91 * MediaQuery.of(context).size.width,
            initialSelection: 0,
            controller: ruleController,
            requestFocusOnTap: true,
            label: const Text('Regel'),
            onSelected: (int? rule) {
              setState(() {
                chosenRule = rule ?? 1;
              });
            },
            dropdownMenuEntries: _ruleEntries ?? [],
          )
        ]),
        Expanded(child: Container()),
        Container(
            constraints: BoxConstraints(maxHeight: 500, maxWidth: 500),
            child: Card(child: EventFeed(null))),
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final response = await supabase.from('events').insert([
            {
              'rule': chosenRule,
              'artist': chosenArtist,
            }
          ]).execute();
          artistController.clear();
          ruleController.clear();
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
