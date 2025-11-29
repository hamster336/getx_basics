import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_basics/models/note_controller.dart';
import 'package:getx_basics/models/notes.dart';

class WriteNote extends StatefulWidget {
  final Notes? note;

  const WriteNote({super.key, this.note});

  @override
  State<WriteNote> createState() => _WriteNoteState();
}

class _WriteNoteState extends State<WriteNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final controller = Get.find<NoteController>();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () async {
            if (widget.note != null) {
              if (widget.note!.title.trim().isNotEmpty &&
                  widget.note!.content.trim().isNotEmpty) {
                widget.note!.time = DateTime.now().millisecondsSinceEpoch
                    .toString();

                await controller.saveNote(widget.note!);
              }
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
                      // border: InputBorder.none,
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                    ),
                  ),

                  Text(
                    // widget.note?.time ?? '12:00 | 1 Jan 2025',
                    '12:00 | 1 Jan 2025',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

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
}
