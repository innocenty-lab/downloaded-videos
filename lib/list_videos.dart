import 'dart:io';

import 'package:flutter/material.dart';

class ListVideos extends StatefulWidget {
  const ListVideos({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ListVideos> createState() => _ListVideosState();
}

class _ListVideosState extends State<ListVideos> {
  final Directory _videoDir = Directory('/storage/emulated/0/KGVideos');

  //DIR SALAH
// final Directory _videoDir = Directory('/storage/emulated/0/Vido');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Builder(
          builder: (context) {

            if (!Directory(_videoDir.path).existsSync()) {

              return const Center(
                child: Text(
                  'Directory not found',
                  style: TextStyle(fontSize: 18.0),
                ),
              );
              
            } else {

              final videoList = _videoDir
              .listSync()
              .map((item) => item.path)
              .where((item) => item.endsWith('.mp4'))
              .toList(growable: false);
              
              if (videoList.isNotEmpty) {

                return const Center(
                  child: Text(
                    'Yeayy, Videos Found!!!!',
                    style: TextStyle(fontSize: 18.0),
                  ),
                );

              } else {

                return const Center(
                  // child: CircularProgressIndicator(),
                    child: Text(
                      'Sorry, No Videos Found!',
                      style: TextStyle(fontSize: 18.0),
                    ),
                );

              }
            }

          },
        )
      )
    );
  }
}
