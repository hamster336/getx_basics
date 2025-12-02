import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_basics/models/local_storage.dart';
import 'package:getx_basics/models/note_controller.dart';
import 'package:getx_basics/models/notes.dart';
import 'package:getx_basics/models/notes_card.dart';
import 'package:getx_basics/screens/write_note.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotesController>();

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Notes',
          style: TextStyle(
            fontSize: 35,
            letterSpacing: 0.35,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SearchBar(
              onTap: () => log('${LocalStorage.getNotes().length}'),
              // backgroundColor: WidgetStatePropertyAll(Colors.transparent),
              elevation: WidgetStatePropertyAll(3),
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 15),
              ),
              leading: Icon(Icons.search),
              hintText: 'Search',
              hintStyle: WidgetStatePropertyAll(TextStyle(fontSize: 18)),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Obx(() {
                if (controller.notes.isNotEmpty) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.notes.length,
                    itemBuilder: (context, index) {
                      if (controller.notes.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'No notes Saved.',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return NotesCard(note: controller.notes[index]);
                      }
                    },
                  );
                } else {
                  return Center(
                    child: const Text(
                      'Nothing to see here.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
              }),
            ),
          ),
        ],
      ),

      floatingActionButton: ElevatedButton(
        onPressed: () {
          Get.to(
            () => WriteNote(
              note: Notes(
                title: '',
                content: '',
                time: DateTime.now().millisecondsSinceEpoch.toString(),
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(10),
          shape: CircleBorder(),
          backgroundColor: Colors.orange,
        ),
        child: Icon(Icons.add, size: 35, color: Colors.white),
      ),
    );
  }
}