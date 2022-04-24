//the first page of the exercise components
import 'dart:convert';
import 'package:get/get.dart';
import 'package:puppy_pal/pages/exercise/video_exercise.dart';
import 'package:flutter/material.dart';
import '../../../Widgets/nav_bar.dart';
import '../../Widgets/colors.dart' as color;

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key}) : super(key: key);
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  List info = [];

  _initData() async {
    await DefaultAssetBundle.of(
            context) //default asset bundle of the data later used for displaying videos
        .loadString("json/info.json")
        .then((value) {
      setState(() {
        info = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

//Page display design
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text('Exercise with Puppy'), //top title in app bar
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
                width: MediaQuery.of(context)
                    .size
                    .width, //uses higher level view of the current available size
                height: 200,
                margin: const EdgeInsets.only(
                  //margin
                  top: 30,
                  left: 20,
                  right: 20,
                ),
                decoration: BoxDecoration(
                  //creates box
                  gradient: LinearGradient(
                    //linear gradient added
                    colors: [
                      color.AppColor.boxColor1.withOpacity(0.9),
                      color.AppColor.boxColor2.withOpacity(0.75),
                      Colors.white //with 3 colours
                    ],
                    begin: Alignment.bottomLeft, //start
                    end: Alignment.topRight, //end of gradient
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(5, 10),
                      blurRadius: 10,
                      color: color.AppColor.boxColor1.withOpacity(0.4),
                    ),
                  ],
                ),
                child: Stack(
                  //creates a stacked layout for components
                  children: [
                    Container(
                      height: 200,
                      width: 175,
                      margin: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          //image shown in decoration box
                          image: AssetImage(
                            "assets/Images/puppyworkout.png",
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      margin: const EdgeInsets.only(
                        left: 160,
                        top: 40,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          // ignore: prefer_const_constructors
                          Text(
                            "Puppy is ready",
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // ignore: prefer_const_constructors
                          Text(
                            "to exercise",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              left: 80,
                              top: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(60), //circular edges
                              boxShadow: [
                                BoxShadow(
                                  //shadow added in box decoration
                                  color: color.AppColor.boxColor1,
                                  blurRadius: 20,
                                  offset: const Offset(10, 3), //shadow's offset
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => const VideoExercise());
                              },
                              child: const Icon(
                                Icons.play_circle_fill,
                                color: Colors.white,
                                size: 55,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(
                      "Exercises:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: color.AppColor.menuText,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  //expanded widget for using for all available space on main axis
                  child: ListView.builder(
                //scrollable array
                itemCount: info.length, //data from info.json file
                itemBuilder: (_, i) {
                  return Column(
                    children: [
                      InkWell(
                        //area that responds to tap gestures
                        onTap: () {
                          Get.to(() => const VideoExercise());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          padding: const EdgeInsets.only(
                            bottom: 25,
                            top: 25,
                            right: 30,
                          ),
                          margin: const EdgeInsets.only(
                            bottom: 20,
                            left: 15,
                            right: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              alignment: Alignment.centerLeft,
                              image: AssetImage(
                                info[i][
                                    'img'], //from the array json file, it uses the images according to their key/value pair
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                offset: const Offset(5, 5),
                                color:
                                    color.AppColor.boxColor2.withOpacity(0.2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                info[i][
                                    'title'], //from the json file uses the values t display the title for each component
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                  color: color.AppColor.plainText,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ))
            ],
          ),
        ),
      );
}
