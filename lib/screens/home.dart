import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_basics/models/note_controller.dart';
import 'package:getx_basics/models/notes.dart';
import 'package:getx_basics/models/notes_card.dart';
import 'package:getx_basics/models/search_controller.dart';
import 'package:getx_basics/models/select_controller.dart';
import 'package:getx_basics/screens/write_note.dart';

class Home extends StatelessWidget {
  final TextEditingController controller;
  Home({super.key}) : controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final noteController = Get.find<NotesController>();
    final selectController = Get.find<SelectController>();
    final searchController = Get.find<SearchNoteController>();

    void delete() {
      Get.defaultDialog(
        title: 'Confirm Delete?',
        titleStyle: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: Colors.red,
        ),
        middleText: 'Are you sure you want to delete selected notes?',
        middleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        barrierDismissible: false, // forces user to choose
        cancel: TextButton(
          onPressed: () => Get.back(), // pop the dialog box
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 17, color: Colors.blue),
          ),
        ),
        confirm: TextButton(
          onPressed: () async {
            await noteController.deleteNotes(
              selectController.selectedIndex.toList(),
            );
            selectController.selectionMode.value = false;
            Get.back(); // pop dialog box
          }, // pop the dialog box
          child: const Text(
            'Yes',
            style: TextStyle(fontSize: 17, color: Colors.red),
          ),
        ),
      );
    }

    void selectAll({bool all = true}) {
      if (all) {
        for (var note in noteController.notes) {
          selectController.selectedIndex.add(note.key);
        }
      } else {
        for (var note in noteController.notes) {
          selectController.selectedIndex.remove(note.key);
        }
      }
    }

    void search(String text) {
      searchController.match.clear();
      for (var note in noteController.notes) {
        if (note.title.toLowerCase().contains(text) ||
            note.content.toLowerCase().contains(text)) {
          searchController.match.add(note);
        }
      }
    }

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: Row(
            children: [
              Expanded(
                child: Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 0.35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              if (selectController.selectionMode.value)
                IconButton(
                  onPressed: () {
                    if (selectController.selectedIndex.isNotEmpty) delete();
                  },
                  icon: Icon(Icons.delete, size: 30),
                ),
            ],
          ),
        ),

        body: GestureDetector(
          onTap: () => selectController.selectionMode.value = false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: SearchBar(
                  onChanged: (value) {
                    if (controller.text.trim().isNotEmpty) {
                      searchController.searchEmpty.value = false;
                      search(controller.text.trim().toLowerCase());
                    } else {
                      searchController.searchEmpty.value = true;
                      searchController.match.clear();
                    }
                  },
                  controller: controller,
                  elevation: WidgetStatePropertyAll(2.5),
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 15),
                  ),
                  leading: Icon(Icons.search),
                  hintText: 'Search',
                  hintStyle: WidgetStatePropertyAll(TextStyle(fontSize: 18)),
                ),
              ),

              if (selectController.selectionMode.value)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        selectController.selectAll.value =
                            !selectController.selectAll.value;

                        if (selectController.selectAll.value) {
                          selectAll();
                        } else {
                          selectAll(all: false);
                        }
                      },
                      child: Icon(
                        (selectController.selectAll.value ||
                                noteController.notes.length ==
                                    selectController.selectedIndex.length)
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                      ),
                    ),

                    Text(
                      'SelectAll',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ).paddingSymmetric(horizontal: 5),

                    Spacer(),

                    GestureDetector(
                      onTap: () {
                        selectController.selectionMode.value = false;
                        selectController.selectedIndex.clear();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ).paddingOnly(right: 20),
                  ],
                ).paddingOnly(left: 20, top: 10),

              (!searchController.searchEmpty.value)
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        child: (searchController.match.isNotEmpty)
                            ? ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: searchController.match.length,
                                itemBuilder: (context, index) {
                                  if (searchController.match.isEmpty) {
                                    return Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'No match found.',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return NotesCard(
                                      note: searchController.match[index],
                                    );
                                  }
                                },
                              )
                            : Center(
                                child: const Text(
                                  'Nothing to see here.',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                      ),
                    )
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        child: (noteController.notes.isNotEmpty)
                            ? ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: noteController.notes.length,
                                itemBuilder: (context, index) {
                                  if (noteController.notes.isEmpty) {
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
                                    return NotesCard(
                                      note: noteController.notes[index],
                                    );
                                  }
                                },
                              )
                            : Center(
                                child: const Text(
                                  'Nothing to see here.',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                      ),
                    ),
            ],
          ),
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
    });
  }
}
