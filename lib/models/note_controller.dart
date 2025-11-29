import 'package:get/get.dart';
import 'package:getx_basics/models/local_storage.dart';
import 'package:getx_basics/models/notes.dart';

class NoteController extends GetxController{
  List<Notes> notes = <Notes>[].obs;

  @override
  void onInit(){
    super.onInit();
    loadNotes();
  }

  void loadNotes(){
    notes.addAll(LocalStorage.getNotes());
  }

  Future<void> saveNote(Notes note) async {
    await LocalStorage.saveNote(note);
    notes.add(note);
  }

  Future<void> deleteNote(List<int> indices) async { 
    indices.sort((a,b) => b.compareTo(a));
    List<Notes> toDelete = [];

    for(var index in indices){
      toDelete.add(notes[index]);
      notes.removeAt(index);
    }
    await LocalStorage.deleteNotes(toDelete);
  }

  // void updateNote(Notes newNote, int index) => notes[index] = newNote;
}