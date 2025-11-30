import 'package:get/get.dart';
import 'package:getx_basics/models/local_storage.dart';
import 'package:getx_basics/models/notes.dart';

class NotesController extends GetxController {
  List<Notes> notes = <Notes>[].obs;

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
    if (!notes.contains(note)) notes.add(note);
  }

  Future<void> deleteNotes(List<int> indices) async {
    indices.sort((a, b) => b.compareTo(a));
    List<Notes> toDelete = [];

    for (var index in indices) {
      toDelete.add(notes[index]);
      notes.removeAt(index);
    }
    await LocalStorage.deleteNotes(toDelete);
  }

  Future<void> deleteSingleNote(Notes note) async{
    int index = notes.indexOf(note);
    notes.removeAt(index);
    await LocalStorage.deleteNotes([note]);
  }

  // void updateNote(Notes newNote, int index) => notes[index] = newNote;
}
