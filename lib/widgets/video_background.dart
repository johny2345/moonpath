import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: new ExactAssetImage('assets/yacht/images/2.jpg'),
            fit: BoxFit.cover,
            colorFilter:
                ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dst)),
      ),
    );
  }
}

class VideoBackground extends StatefulWidget {
  const VideoBackground({Key? key}) : super(key: key);

  @override
  _VideoBackgroundState createState() => _VideoBackgroundState();
}

class _VideoBackgroundState extends State<VideoBackground> {
  VideoPlayerController _controller = VideoPlayerController.asset(
      "assets/yacht/videos/yacht_advertisement.mp4");

  @override
  void initState() {
    super.initState();

    _controller.initialize().then((_) {
      _controller.setLooping(true);
      Timer(Duration(milliseconds: 100), () {
        setState(() {
          _controller.play();
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _getVideoBackground() {
      return AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(milliseconds: 1000),
        child: VideoPlayer(_controller),
      );
    }

    _getBackgroundColor() {
      return Container(
        color: Colors.blue.withAlpha(20),
      );
    }

    print("video status: ");
    print(_controller);
    return Container(
      child: Center(
        child: _controller.value.isInitialized
            ? BackgroundImage()
            // Stack(
            //     children: <Widget>[
            //       AspectRatio(
            //         aspectRatio: _controller.value.aspectRatio,
            //         child: VideoPlayer(_controller),
            //       ),
            //       _getVideoBackground(),
            //       _getBackgroundColor(),
            //     ],
            //   )
            : BackgroundImage(),
      ),
    );
  }
}
