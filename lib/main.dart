import 'package:downloaded_videos/list_videos.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Downloaded Videos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListVideos(title: 'Downloaded Videos!'),
    );
  }
}