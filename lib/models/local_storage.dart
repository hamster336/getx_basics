import 'package:hive_ce_flutter/hive_flutter.dart';
import 'notes.dart';

class LocalStorage {
  static const String _notesBox = 'notes_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NotesAdapter());
    await Hive.openBox<Notes>(_notesBox);
  }

  static void saveNote(Notes note) async {
    final box = Hive.box<Notes>(_notesBox);
    await box.add(note);
  }

  static List<Notes> getNotes() {
    final box = Hive.box<Notes>(_notesBox);
    return box.values.toList();
  }

  static void deleteNotes(List<int> list) async {
    final box = Hive.box<Notes>(_notesBox);
    for (var i in list) {
      await box.deleteAt(i);
    }
  }
}
