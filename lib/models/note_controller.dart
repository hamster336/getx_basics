import 'package:get/get.dart';
import 'package:getx_basics/models/local_storage.dart';
import 'package:getx_basics/models/notes.dart';

class NotesController extends GetxController {
  RxList<Notes> notes = <Notes>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }

  void loadNotes() {
    notes.addAll(LocalStorage.getNotes());
  }

  Future<void> saveNote(Notes note) async {
    await LocalStorage.saveNote(note);

    int index = notes.indexWhere((n) => n.key == note.key);

    if (index == -1) {
      notes.add(note); // add a new note
    } else {
      notes[index] = note; // update existing note
    }
    notes.sort((a, b) => b.time.compareTo(a.time));
    notes.refresh();
  }

  Future<void> deleteNotes(List<int> keys) async {
    for (var key in keys) {
      notes.removeWhere((n) => n.key == key);
    }
    notes.refresh();
    await LocalStorage.deleteNotes(keys);
  }

  Future<void> deleteNote(Notes note) async {
    notes.removeWhere((n) => n.key == note.key);
    notes.refresh();
    await LocalStorage.deleteNote(note);
  }
}
