import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_basics/models/notes.dart';
import 'package:getx_basics/screens/write_note.dart';

class NotesCard extends StatelessWidget {
  final Notes note;
  const NotesCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    Notes copy = note;

    return SizedBox(
      // height: size.height * 0.1,
      child: InkWell(
        onTap: () => Get.to(WriteNote(note: note)),
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  (note.title.isNotEmpty) ? note.title : 'Untitled',
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
                  note.content,
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

  String getTitle(Notes copy) {
    String text = '';
    if (copy.title.isEmpty) {
      int index = copy.content.indexOf('\n');
      if (index == -1) index = copy.content.length;
      text = copy.content.substring(0, index + 1);
    } else {
      return copy.title;
    }
    return text;
  }

  // String getContent(Notes copy) {

  // }

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

    return '${date.day} ${months[date.month - 1]}';
  }

  static String formatTime({
    required BuildContext context,
    required String time,
  }) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }
}
