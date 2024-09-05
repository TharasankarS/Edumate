import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

class VideoP extends StatefulWidget {
  const VideoP({Key? key}) : super(key: key);

  @override
  State<VideoP> createState() => _VideoPState();
}

class _VideoPState extends State<VideoP> {
  late CustomVideoPlayerController _customVideoPlayerController;
  String output = "Output.mp4";
  String assetPath = "assets/videos/";

  @override
  void initState() {
    super.initState();
    initializeVP();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Preview"),
      ),
      backgroundColor: const Color.fromARGB(255, 176, 174, 155),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 320,
              color: Colors.black,
              child: CustomVideoPlayer(customVideoPlayerController: _customVideoPlayerController),
            ),
            ElevatedButton(
              onPressed: () {
                refreshVideo();
              },
              child: const Text("Refresh"),
            ),
          ],
        ),
      ),
    );
  }

  void initializeVP() {
    CachedVideoPlayerController videoPlayerController =
        CachedVideoPlayerController.asset(assetPath + output)
          ..initialize().then((_) {
            setState(() {});
          });
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  void refreshVideo() {
    // Dispose of the current video player controller
    _customVideoPlayerController.dispose();

    // Initialize a new video player controller with the same video source
    initializeVP();
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }
}
