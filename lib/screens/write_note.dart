import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_basics/models/note_controller.dart';
import 'package:getx_basics/models/notes.dart';

class WriteNote extends StatelessWidget {
  final Notes note;

  final TextEditingController titleController;
  final TextEditingController contentController;
  final NotesController controller;

  WriteNote({super.key, required this.note})
    : titleController = TextEditingController(text: note.title),
      contentController = TextEditingController(text: note.content),
      controller = Get.find<NotesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            _save();
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// title text field
                  TextField(
                    controller: titleController,
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                    ),
                  ),

                  Text(
                    getTime(context, note.time),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),

            // body or content textField
            SliverFillRemaining(
              hasScrollBody: false,
              child: TextField(
                controller: contentController,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Start typing.',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTime(BuildContext context, String time) {
    if (time.isEmpty) return '';
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${TimeOfDay.fromDateTime(date).format(context)} | ${'${months[date.month - 1]} ${date.day}, ${date.year}'}';
  }

  bool hasChanged(String a, String b) =>
      ((note.title != a) || (note.content != b));

  void _save() async {
    final newTitle = titleController.text.trim();
    final newContent = contentController.text.trim();

    bool isEmpty =
        newTitle.isEmpty &&
        newContent.isEmpty; // check if both the fields are empty or not

    bool isChanged =
        (newTitle != note.title) ||
        (newContent !=
            note.content); // check if any of the field is changed or not

    if (isChanged) {
      note.title = newTitle;
      note.content = newContent;

      if (!isEmpty) {
        // if changed but not empty, update time and save
        note.time = DateTime.now().millisecondsSinceEpoch.toString();

        await controller.saveNote(note);
      } else {
        // if fields were changed and now are empty, delete the note
        await controller.deleteNote(note);
      }
    }
  }
}
