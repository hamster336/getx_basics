import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: customTextField(
                  'Title',
                  titleController,
                  fs: 30,
                  fw: FontWeight.w600,
                  ls: 0.5,
                ),
              ),

              Text(
                (widget.note == null) ? 'Jan 1, 2025' : widget.note!.time,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),

              Expanded(
                child: customTextField(
                  'Content',
                  contentController,
                  fs: 20,
                  fw: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customTextField(
    String hintText,
    TextEditingController textController, {
    required double fs,
    required FontWeight fw,
    double? ls,
  }) {
    return TextField(
      // expands: true,
      decoration: InputDecoration(
        // border: InputBorder.none,
        
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: fs, fontWeight: fw, letterSpacing: ls),
      ),
    );
  }
}
