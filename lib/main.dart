import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "First App",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "First App Just Testing",
            style: TextStyle(
              fontSize: 20, // AppBar title font size
              fontWeight: FontWeight.bold,
              color: Colors.white, // AppBar title text color
            ),
          ),
          backgroundColor: Colors.amberAccent, // AppBar background color
          centerTitle: true, // Center the title of AppBar
        ),
        body: const Center(
          child: Text(
            'Hello Pawan Kumar, I think you are doing well',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.purple, // Text color
              fontStyle: FontStyle.italic, // Make text italic
            ),
          ),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
