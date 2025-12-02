import 'dart:developer';

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'notes.dart';

class LocalStorage {
  static const String _notesBox = 'notes_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NotesAdapter());
    await Hive.openBox<Notes>(_notesBox);
  }

  static Future<void> saveNote(Notes note) async {
    final box = Hive.box<Notes>(_notesBox);
    if (note.isInBox) {
      note.save();
    } else {
      await box.add(note);
    }

    log('note saved');
  }

  static List<Notes> getNotes() {
    final box = Hive.box<Notes>(_notesBox);
    final list = box.values.toList();
    list.sort((a, b) => b.time.compareTo(a.time));
    return list;
  }

  static Future<void> deleteNote(Notes note) async {
      await note.delete();
  }

  static Future<void> deleteNotes(List<int> keys) async{
    final box = Hive.box<Notes>(_notesBox);
    for(var key in keys){
      await box.delete(key);
    }
  }
}
