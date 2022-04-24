import 'dart:async';
import 'package:flutter/material.dart';
import '../Widgets/nav_bar.dart';
import '../Widgets/colors.dart' as color;

class ReadingPage extends StatefulWidget {
  const ReadingPage({Key? key}) : super(key: key);
  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  static const maxSeconds = 180;
  int seconds = 0;
  Timer? timer;
  bool pressedStart = false;
  bool pressedStop = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text('Read with Puppy'),
          centerTitle: true,
          backgroundColor: color.AppColor.navbarColour,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              colors: [
                color.AppColor.gradientFirst,
                color.AppColor.gradientSecond
              ],
            ),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                  top: 30,
                  right: 30,
                  left: 30,
                ),
                child: Text(
                  "Press start and read with Puppy",
                  style:
                      TextStyle(fontSize: 20, color: color.AppColor.boxColor1),
                ),
              ),
              Container(
                height: 350,
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                decoration: _pressedStart(
                  pressedStart,
                  pressedStop,
                ),
              ),
              const SizedBox(height: 20),
              _startTimer(),
            ],
          ),
        ),
      );

  void resetTimer() => setState(() => seconds = 0);

  void startCountdown() {
    timer = Timer.periodic(
        const Duration(
          seconds: 1, //change to milliseconds for faster
        ), (_) {
      setState(() {
        if (pressedStart == false) {
          pressedStart = true;
          pressedStop = false;
        }
        if (seconds < maxSeconds) {
          seconds++;
        } else {
          stopCountdown();
        }
      });
    });
  }

  void stopCountdown({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    //stop timer
    timer?.cancel();
    setState(() {
      if (pressedStop == false) {
        pressedStop = true;
        pressedStart = false;
      }
    });
  }

  _startTimer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimer(),
        const SizedBox(
          height: 80,
        ),
        _buttonCreate(),
      ],
    );
  }

  Widget buildTimer() => SizedBox(
        width: 100,
        height: 100,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: 1 - seconds / maxSeconds,
              valueColor: const AlwaysStoppedAnimation(Colors.white),
              backgroundColor: color.AppColor.countdown,
              strokeWidth: 10,
            ),
            Center(
              child: buildTime(),
            ),
          ],
        ),
      );

  Widget buildTime() {
    if (seconds == maxSeconds) {
      return Icon(
        Icons.done,
        color: color.AppColor.countdown,
        size: 112,
      );
    }
    return Text(
      '$seconds',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40,
        color: color.AppColor.boxColor1,
      ),
    );
  }

  _buttonCreate() {
    final isRunning = timer == null ? false : timer!.isActive;

    return isRunning
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.pause,
                  color: Colors.white,
                  size: 20,
                ),
                label: const Text('Pause'),
                onPressed: () {
                  stopCountdown(reset: false);
                },
                style: ElevatedButton.styleFrom(
                  primary: color.AppColor.boxColor1,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.white,
                  size: 20,
                ),
                label: const Text('Reset'),
                onPressed: () {
                  stopCountdown();
                },
                style: ElevatedButton.styleFrom(
                  primary: color.AppColor.boxColor1,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ),
            ],
          )
        : ElevatedButton.icon(
            icon: const Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 20,
            ),
            label: const Text('Start'),
            onPressed: () {
              startCountdown();
            },
            style: ElevatedButton.styleFrom(
              primary: color.AppColor.boxColor1,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
            ),
          );
  }
}

_pressedStart(bool pressedStart, bool pressedStop) {
  if (pressedStart == true) {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
          "assets/Images/PuppyListens.gif",
        ),
      ),
    );
  } else if (pressedStop == true) {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
          "assets/Images/PuppyCongrats.gif",
        ),
      ),
    );
  } else {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
          "assets/Images/puppypal.gif",
        ),
      ),
    );
  }
}
