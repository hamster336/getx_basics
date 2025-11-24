import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(fontSize: 25, letterSpacing: 0.5),
        ),
      ),

      floatingActionButton: ElevatedButton(
        onPressed: () {},
        child: Icon(Icons.add, size: 20),
      ),
    );
  }
}
