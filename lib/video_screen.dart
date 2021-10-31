import 'dart:io';

import 'package:downloaded_videos/list_videos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  File? videoFile;
  VideoScreen({this.videoFile});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController controller;

  @override
  void initState() {
    controller = VideoPlayerController.file(widget.videoFile!);
    controller.addListener(() {setState(() {
      
    });});

    controller.initialize().then((value) => setState(() {
      
    }));

    controller.play();
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offAll(ListVideos());
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: VideoPlayer(controller),
      ),
    );
  }
}