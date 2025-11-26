import 'package:get/get.dart';
import 'package:getx_basics/models/notes.dart';

class NoteController extends GetxController{
  List<Notes> notes = <Notes>[].obs;

  void addNote(Notes note) => notes.add(note);
  void deleteNote(int index) => notes.removeAt(index);
  void updateNote(Notes newNote, int index) => notes[index] = newNote;
}