//general app info

import 'package:flutter/material.dart';
import '../Widgets/nav_bar.dart';
import '../Widgets/colors.dart' as color;

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text('About'),
          centerTitle: true,
          backgroundColor: color.AppColor.navbarColour,
        ),
        body: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: Text(
              "  This app is a part of a research for children on the spectrum. \n  It specifically tries to incorporate the benefits of Autism Assistance Dogs in an accessible electronic form. \n  This app is best csuited for children in the spectrum from the age of 8+.",
              style: TextStyle(color: color.AppColor.boxColor1, fontSize: 18),
            ),
          ),
        ]),
      );
}
