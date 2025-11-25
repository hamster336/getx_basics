import 'package:flutter/material.dart';

class NotesCard extends StatelessWidget {
  final String title;
  final String text;
  final String time;

  const NotesCard({
    super.key,
    required this.title,
    required this.text,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      // height: size.height * 0.1,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),

              Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 10),

              Text(time, style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}
