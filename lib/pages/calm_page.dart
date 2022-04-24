//displays a calming exercise
import 'dart:async';
import 'package:flutter/material.dart';
import '../Widgets/nav_bar.dart';
import '../Widgets/colors.dart' as color;

class CalmPage extends StatefulWidget {
  const CalmPage({Key? key}) : super(key: key);
  @override
  _CalmPageState createState() => _CalmPageState();
}

class _CalmPageState extends State<CalmPage> {
  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;
  bool pressedStart = false;
  bool pressedStop = false;

  //display page
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text('Calm down with Puppy'),
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
                  "Press start to calm with Puppy",
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
                decoration: _pressedButton(pressedStart, pressedStop, seconds),
              ),
              const SizedBox(height: 20),
              _startTimer(),
            ],
          ),
        ),
      );

  void resetTimer() =>
      setState(() => seconds = maxSeconds); //resets the timer button

  void startCountdown() {
    //timer
    timer = Timer.periodic(
        const Duration(
          seconds: 1, //milliseconds: 50, //faster testing
        ), (_) {
      setState(() {
        if (pressedStart == false) {
          pressedStart = true;
          pressedStop = false;
        }
        if (seconds > 0) {
          seconds--;
        } else {
          stopCountdown();
        }
        if (seconds == 0) {
          pressedStart = false;
          pressedStop = false;
        }
      });
    });
  }

  void stopCountdown({bool reset = true}) {
    if (reset) {
      resetTimer(); //if reset is true, the countdown timer takes its initial value
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
        //creates the circular effect of the countdown timer
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
    if (seconds == 0) {
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

_pressedButton(bool pressedStart, bool pressedStop, int seconds) {
  if (pressedStart == true) {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
          "assets/Images/PuppyBreathing.gif",
        ),
      ),
    );
  } else if (pressedStop == true) {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
          "assets/Images/puppypal.gif",
        ),
      ),
    );
  } else if (seconds == 0) {
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
