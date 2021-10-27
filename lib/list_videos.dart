import 'dart:io';
import 'package:flutter/material.dart';
import 'package:thumbnails/thumbnails.dart';

class ListVideos extends StatefulWidget {
  const ListVideos({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ListVideos> createState() => _ListVideosState();
}

// class _ListVideosState extends State<ListVideos> {
//   final Directory _videoDir = Directory('/storage/emulated/0/KGVideos');

//   //DIR SALAH
//   // final Directory _videoDir = Directory('/storage/emulated/0/Vido');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Builder(
//           builder: (context) {

//             if (!Directory(_videoDir.path).existsSync()) {

//               return const Center(
//                 child: Text(
//                   'Directory not found',
//                   style: TextStyle(fontSize: 18.0),
//                 ),
//               );
              
//             } else {

//               final videoList = _videoDir
//               .listSync()
//               .map((item) => item.path)
//               .where((item) => item.endsWith('.mp4'))
//               .toList(growable: false);
              
//               if (videoList.isNotEmpty) {

//                 return const Center(
//                   child: Text(
//                     'Yeayy, Videos Found!!!!',
//                     style: TextStyle(fontSize: 18.0),
//                   ),
//                 );

//               } else {

//                 return const Center(
//                   // child: CircularProgressIndicator(),
//                     child: Text(
//                       'Sorry, No Videos Found!',
//                       style: TextStyle(fontSize: 18.0),
//                     ),
//                 );

//               }
//             }

//           },
//         )
//       )
//     );
//   }
// }


// class _ListVideosState extends State<ListVideos> {
//   final Directory _videoDir = Directory('/storage/emulated/0/KGVideos');

//   //DIR SALAH
//   // final Directory _videoDir = Directory('/storage/emulated/0/Vido');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Builder(
//           builder: (context) {

//             if (!Directory(_videoDir.path).existsSync()) {

//               return const Center(
//                 child: Text(
//                   'Directory not found',
//                   style: TextStyle(fontSize: 18.0),
//                 ),
//               );
              
//             } else {

//               final videoList = _videoDir
//               .listSync()
//               .map((item) => item.path)
//               .where((item) => item.endsWith('.mp4'))
//               .toList(growable: false);
              
//               if (videoList.isNotEmpty) {
//                 return InkWell(
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//                     // child: GridView.builder(
//                     //   itemCount: videoList.length,
//                     //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     //     crossAxisCount: 3,
//                     //     childAspectRatio: 1.6 / 2.0,
//                     //     mainAxisSpacing: 8.0,
//                     //     crossAxisSpacing: 8.0,
//                     //   ),
//                     // ),
                
//                     child: ListView.builder(
//                       // itemCount: files?.length ?? 0,
//                       itemCount: videoList.length,
//                       itemBuilder: (context, index) {
//                         return Card(
//                           child:ListTile(
//                             title: Text(videoList[index].split('/').last),
//                             leading: Icon(Icons.image),
//                             trailing: Icon(Icons.delete, color: Colors.redAccent,),
//                           )
//                         );
//                       },
//                     ),
//                   ),

//                   onTap: () {
//                   },
//                 );

//                 // return const Center(
//                 //   child: Text(
//                 //     'Yeayy, Videos Found!!!!',
//                 //     style: TextStyle(fontSize: 18.0),
//                 //   ),
//                 // );

//               } else {

//                 return const Center(
//                   // child: CircularProgressIndicator(),
//                     child: Text(
//                       'Sorry, No Videos Found!',
//                       style: TextStyle(fontSize: 18.0),
//                     ),
//                 );

//               }
//             }

//           },
//         )
//       )
//     );
//   }
// }



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

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Directory not found',
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              );
              
            } else {

              final videoList = _videoDir
              .listSync()
              .map((item) => item.path)
              .where((item) => item.endsWith('.mp4'))
              .toList(growable: false);

              if (videoList != null) {

                if (videoList.isNotEmpty) {

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: GridView.builder(
                      itemCount: videoList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.6 / 2.0,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      ),

                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Navigator.push(
                            context, 
                            // MaterialPageRoute(
                            //   builder: (context) => PlayStatus(
                            //     videoFile: videoList[index],
                            //   ),
                            // ),

                            MaterialPageRoute(builder: (context) => videoList[index]),
                          ),

                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(6)),
                            child: Stack(
                              children: [

                                Center(
                                  child: FutureBuilder(
                                    future: _getImage(videoList[index]),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        if (snapshot.hasData) {
                                          return Hero(
                                            tag: videoList, 
                                            // child: Image.file(
                                            //   File(snapshot.data),
                                            //   fit: BoxFit.cover,
                                            // ),
                                            child: Image.asset(
                                              "assets/images/video_loader.gif",
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        } else {
                                          return Center(
                                            child: Image.asset(
                                              "assets/images/video_loader.gif",
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        }
                                      } else {
                                        return Center(
                                          child: Image.asset(
                                            "assets/images/video_loader.gif",
                                            fit: BoxFit.fitHeight,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),

                                const Positioned(
                                  child: Center(
                                    child: Icon(
                                      Icons.play_circle_outline_outlined,
                                      size: 36,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ),
                        );
                      },
                    ),
                  );

                } else {
                  return const Center(
                    child: Text(
                      'Sorry, No Videos Found.',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  );
                }
                
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

            }
          },
        )
      )
    );
  }

  _getImage(videoPathUrl) async {
    await Future.delayed(const Duration(milliseconds: 500));
    String thumb = await Thumbnails.getThumbnail(
      videoFile: videoPathUrl,
      imageType: ThumbFormat.PNG,
      quality: 1
    );
    return thumb;
  }

}