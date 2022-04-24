import 'dart:async';

import 'package:flutter/material.dart';
import 'package:puppy_pal/my_icons_icons.dart';
import '../Widgets/nav_bar.dart';
import '../Widgets/colors.dart' as color;

class CarePage extends StatefulWidget {
  const CarePage({Key? key}) : super(key: key);
  @override
  _CarePageState createState() => _CarePageState();
}

class _CarePageState extends State<CarePage> {
  static const maxSeconds = 5;
  int seconds = maxSeconds;
  Timer? timer;
  bool _pressedFood = false;
  bool _pressedLove = false;

  void resetTimer() => setState(() => seconds = maxSeconds);

  void startCountdown() {
    timer = Timer.periodic(
        const Duration(
          seconds: 1, //change to milliseconds for faster
        ), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        }
        if (seconds == 0) {
          _pressedFood = false;
          _pressedLove = false;
          resetTimer();
          timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text('Care for Puppy'),
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
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                //width: MediaQuery.of(context).size.width,
                height: 350,
                margin: const EdgeInsets.only(
                  top: 30,
                  left: 20,
                  right: 20,
                ),
                decoration: _imageChoose(_pressedLove, _pressedFood),
              ),
              Text(
                "Give Puppy: ",
                style: TextStyle(
                  fontSize: 30,
                  color: color.AppColor.plainText,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      color: color.AppColor.boxColor1.withOpacity(0.2),
                      child: InkWell(
                        splashColor: color.AppColor.boxColor2,
                        onTap: () {
                          setState(
                            () {
                              if (_pressedFood == false) {
                                _pressedFood = true;
                                _pressedLove = false;
                                startCountdown();
                              }
                            },
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              MyIcons.dogFoodIcon,
                              size: 60,
                              color: color.AppColor.pageIcons,
                            ),
                            Text(
                              "Food",
                              style: TextStyle(
                                fontSize: 40,
                                color: color.AppColor.plainText,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      color: color.AppColor.boxColor1.withOpacity(0.2),
                      child: InkWell(
                        splashColor: color.AppColor.boxColor2,
                        onTap: () {
                          setState(
                            () {
                              if (_pressedLove == false) {
                                _pressedLove = true;
                                _pressedFood = false;
                                startCountdown();
                              }
                            },
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              MyIcons.careIcon,
                              size: 60,
                              color: color.AppColor.pageIcons,
                            ),
                            Text(
                              "Love",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: color.AppColor.plainText),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

_imageChoose(bool _pressedLove, bool _pressedFood) {
  if (_pressedLove == true) {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
          "assets/Images/PuppyPalLove.gif",
        ),
      ),
    );
  } else if (_pressedFood == true) {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
          "assets/Images/PuppyPalFood.gif",
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
