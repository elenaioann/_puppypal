// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:puppy_pal/pages/exercise/exercise_page.dart';
import 'package:video_player/video_player.dart';
import '../../Widgets/colors.dart' as color;

class VideoExercise extends StatefulWidget {
  const VideoExercise({Key? key}) : super(key: key);

  @override
  State<VideoExercise> createState() => _VideoExerciseState();
}

class _VideoExerciseState extends State<VideoExercise> {
  List videoInfo = [];
  int _isPlayingIndex = -1;
  bool _playArea = false;
  bool _isPlaying = false;
  bool _disposed = false;
  VideoPlayerController? _controller;

  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/videoinfo.json")
        .then((value) {
      setState(() {
        videoInfo = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _playArea == false
            ? BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  colors: [
                    color.AppColor.boxColor1.withOpacity(0.9),
                    color.AppColor.boxColor2.withOpacity(0.75),
                    Colors.white
                  ],
                ),
              )
            : BoxDecoration(color: color.AppColor.boxColor2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _playArea == false
                ? Container(
                    padding:
                        const EdgeInsets.only(top: 60, left: 30, right: 30),
                    // width: MediaQuery.of(context).size.width,
                    height: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 30,
                                color: color.AppColor.menuBackground,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Execises",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: color.AppColor.pageSubtitles,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 200,
                          width: 175,
                          margin: const EdgeInsets.only(
                            bottom: 20,
                          ),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/Images/puppyworkout.png",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        height: 100,
                        padding: const EdgeInsets.only(
                          top: 25,
                          left: 20,
                          right: 20,
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(() => const ExercisePage());
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: color.AppColor.pageIcons2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/Images/JumpingJacks.gif",
                            ),
                          ),
                        ),
                      ),
                      _playView(context),
                      _controlView(context),
                    ],
                  ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Exercises: ",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: color.AppColor.pageTitles,
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: _listView(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _controlView(BuildContext context) {
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton(
            onPressed: () async {
              final index = _isPlayingIndex - 1;
              // ignore: prefer_is_empty
              if (index >= 0 && videoInfo.length >= 0) {
                _onClickVideo(index);
              } else {
                Get.snackbar(
                  "Video",
                  "",
                  snackPosition: SnackPosition.BOTTOM,
                  icon: Icon(
                    Icons.face,
                    size: 30,
                    color: color.AppColor.boxColor1,
                  ),
                  backgroundColor: color.AppColor.menuBackground,
                  colorText: color.AppColor.menuText,
                  messageText: Text(
                    "You are on the first video",
                    style:
                        TextStyle(fontSize: 20, color: color.AppColor.menuText),
                  ),
                );
              }
            },
            child: const Icon(
              Icons.fast_rewind,
              size: 36,
              color: Colors.white,
            ),
          ),
          FlatButton(
            onPressed: () async {
              if (_isPlaying) {
                setState(() {
                  _isPlaying = false;
                });
                _controller?.pause();
              } else {
                setState(() {
                  _isPlaying = true;
                });
                _controller?.play();
              }
            },
            child: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              size: 36,
              color: Colors.white,
            ),
          ),
          FlatButton(
            onPressed: () async {
              final index = _isPlayingIndex + 1;
              if (index <= videoInfo.length - 1) {
                _onClickVideo(index);
              } else {
                Get.snackbar(
                  "Video",
                  "",
                  snackPosition: SnackPosition.BOTTOM,
                  icon: Icon(
                    Icons.face,
                    size: 30,
                    color: color.AppColor.boxColor1,
                  ),
                  backgroundColor: color.AppColor.menuBackground,
                  colorText: color.AppColor.menuText,
                  messageText: Text(
                    "You are on the last video",
                    style:
                        TextStyle(fontSize: 20, color: color.AppColor.menuText),
                  ),
                );
              }
            },
            child: const Icon(
              Icons.fast_forward,
              size: 36,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
          child: Text(
            "Loading...",
            style: TextStyle(
              fontSize: 20,
              color: color.AppColor.plainText2,
            ),
          ),
        ),
      );
    }
  }

  // ignore: prefer_typing_uninitialized_variables
  var _onUpdateControllerTime;
  void _onControllerUpdate() async {
    if (_disposed) {
      return;
    }

    final now = DateTime.now().microsecondsSinceEpoch;
    _onUpdateControllerTime = 0;
    if (_onUpdateControllerTime > now) {
      return;
    }

    _onUpdateControllerTime = now + 500;

    final controller = _controller;
    if (controller == null) {
      debugPrint("controller is null");
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint("controller can not be initialized");
      return;
    }
    final playing = controller.value.isPlaying;
    _isPlaying = playing;
  }

  _onClickVideo(int index) {
    final controller =
        VideoPlayerController.network(videoInfo[index]["videoUrl"]);
    final old = _controller;
    _controller = controller;
    if (old != null) {
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});
    // ignore: avoid_single_cascade_in_expression_statements
    controller
      ..initialize().then(
        (_) {
          old?.dispose();
          _isPlayingIndex = index;
          controller.addListener(_onControllerUpdate);
          _controller?.play();
          setState(() {});
        },
      );
  }

  _listView() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      itemCount: videoInfo.length,
      itemBuilder: (_, int index) {
        return GestureDetector(
          onTap: () {
            _onClickVideo(index);
            debugPrint(index.toString());
            setState(
              () {
                if (_playArea == false) {
                  _playArea = true;
                }
              },
            ); //hide top to display video
          },
          // ignore: sized_box_for_whitespace
          child: _buildCard(index),
        );
      },
    );
  }

  _buildCard(int index) {
    return SizedBox(
      height: 135,
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(
                      videoInfo[index]["thumbnail"],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videoInfo[index]["title"],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      videoInfo[index]["time"],
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
