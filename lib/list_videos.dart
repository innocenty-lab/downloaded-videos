import 'dart:io';
// import 'package:downloaded_videos/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
// import 'package:thumbnails/thumbnails.dart';
// import 'package:get/get.dart';

class ListVideos extends StatefulWidget {
  // const ListVideos({Key? key, required this.title}) : super(key: key);

  // final String title;

  @override
  State<ListVideos> createState() => _ListVideosState();
}

class _ListVideosState extends State<ListVideos> {
  // final Directory _videoDir = Directory('/storage/emulated/0/KGVideos');
  final Directory _videoDir = Directory('/storage/emulated/0/KGDocuments');

  //DIR SALAH
  // final Directory _videoDir = Directory('/storage/emulated/0/Vido');

  //=================================Open File======================================
  // var _openResult = 'Unknown';

  void openFile(String filepath) async {
    
    // FilePickerResult result = await FilePicker.platform.pickFiles();

    // if (result != null) {
    //   filePath = result.files.single.path;
    // } else {
    //   // User canceled the picker
    // }

    // final _result = await OpenFile.open(filepath);
    await OpenFile.open(filepath);

    // if (filepath.contains(".mp4")) {
    //   Get.to(VideoScreen(videoFile: File(filepath),));
    // } else {

    // }
    
    // print(_result.message);
    // print(filePath.path);

    // setState(() {
    //   _openResult = "type=${_result.type}  message=${_result.message}";
    // });
  }
  //===============================================================================

  Future<void> deleteFile(File files) async {
    try {

      // if (await file.exists()) {
      //   await file.delete();
      // }

      final file = files;
      await file.delete();
      
    } catch (e) {
      print('gagal');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Videos"),
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
              // .where((item) => item.endsWith('.mp4'))
              // .where((item) => item.endsWith('.mp4')||item.endsWith('.pdf'))
              .toList(growable: false);
              
              if (videoList.isNotEmpty) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  // child: GridView.builder(
                  //   itemCount: videoList.length,
                  //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 3,
                  //     childAspectRatio: 1.6 / 2.0,
                  //     mainAxisSpacing: 8.0,
                  //     crossAxisSpacing: 8.0,
                  //   ),
                  // ),
                
                  child: ListView.builder(
                    // itemCount: files?.length ?? 0,
                    itemCount: videoList.length,
                    itemBuilder: (context, index) {
                      print(videoList[index].toString());
                      return InkWell(
                        child: Card(
                          child:ListTile(
                            title: Text(videoList[index].split('/').last),
                            leading: Icon(Icons.image),
                            // trailing: Icon(Icons.delete, color: Colors.redAccent,),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent,),
                              onPressed: () {
                                deleteFile(File(videoList[index].toString()));
                              },
                            ),
                          )
                        ),
                        onTap: () => openFile(videoList[index].toString()),
                      );
                    },
                  ),
                );

                // return const Center(
                //   child: Text(
                //     'Yeayy, Videos Found!!!!',
                //     style: TextStyle(fontSize: 18.0),
                //   ),
                // );

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