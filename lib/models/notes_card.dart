import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_basics/models/notes.dart';
import 'package:getx_basics/models/select_controller.dart';
import 'package:getx_basics/screens/write_note.dart';

class NotesCard extends StatelessWidget {
  final Notes note;
  const NotesCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    SelectController selectController = Get.find<SelectController>();

    bool selected = (selectController.selectedIndex.contains(note.key));

    return SizedBox(
      child: InkWell(
        onTap: () {
          if (selectController.selectionMode.value) {
            // if selection mode is on, select or deselect on tap
            if (selected) {
              selectController.selectedIndex.remove(note.key);
              if (selectController.selectedIndex.isEmpty) {
                // if selected Index is empty, turn off selection mode
                selectController.selectionMode.value = false;
              }
            } else {
              selectController.selectedIndex.add(note.key);
            }
          } else {
            // if selection mode is off, navigate to write note screen
            Get.to(WriteNote(note: note));
          }
        },
        onLongPress: () {
          selectController.selectionMode.value = true;
          selectController.selectedIndex.add(note.key);
        },
        child: Card(
          // surfaceTintColor: ,
          elevation: selected ? 6 : 2,
          borderOnForeground: true,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  getText(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),

                // content
                Text(
                  getText(title: false),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),

                const SizedBox(height: 10),

                // time
                Text(
                  getDate(context, note.time),
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            
          ),
        ),
      ),
    );
  }

  String getText({bool title = true}) {
    String text = '';
    int l = note.content.length;
    if (note.title.isEmpty) {
      int index = note.content.indexOf('\n');
      if (index == -1) index = l;
      if (title) {
        text = note.content.substring(0, (index + 1 > l ? index : index + 1));
      } else {
        text = note.content.substring(index, note.content.length).trim();
      }
    } else {
      return (title) ? note.title : note.content;
    }
    return text;
  }

  String getDate(BuildContext context, String time) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    DateTime now = DateTime.now();

    final difference = date.difference(now).inDays;

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

    if (difference == 0) return formatTime(context: context, time: time);
    if (difference == 1) return 'Yesterday';

    if (date.year < now.year) return '${date.day}/${date.month}/${date.year}';

    return '${months[date.month - 1]} ${date.day}';
  }

  static String formatTime({
    required BuildContext context,
    required String time,
  }) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }
}
