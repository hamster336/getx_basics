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
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () async {
            final newTitle = titleController.text.trim();
            final newContent = contentController.text.trim();

            note.title = newTitle;
            note.content = newContent;
            if (note.title.isNotEmpty || note.content.isNotEmpty) {
              note.time = DateTime.now().millisecondsSinceEpoch.toString();

              await controller.saveNote(
                note,
              ); // save only if eihter title or content are not empty
            }
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
                  hintText: 'Content',
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
    return '${TimeOfDay.fromDateTime(date).format(context)} | ${'${date.day}/${date.month}/${date.year}'}';
  }

  bool hasChanged(String a, String b) =>
      ((note.title != a) || (note.content != b));
}
