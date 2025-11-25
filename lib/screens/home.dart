import 'package:flutter/material.dart';
import 'package:getx_basics/models/notes_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'Notes',
          style: TextStyle(
            fontSize: 30,
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
              elevation: WidgetStatePropertyAll(4),
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
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return NotesCard(
                    title: 'Title',
                    text: 'Learn state Management in flutter with getx',
                    time: '12:00',
                  );
                },
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: ElevatedButton(
        onPressed: () {},
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
