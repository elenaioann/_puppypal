import 'package:flutter/material.dart';
import 'Widgets/nav_bar.dart';
import 'pages/care_page.dart';
import 'package:get/get.dart';
import '../Widgets/colors.dart' as color;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'PuppyPal';

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: _title,
      theme: ThemeData(scaffoldBackgroundColor: color.AppColor.gradientFirst),
      home: const CarePage(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text(MyApp._title),
      ),
    );
  }
}
