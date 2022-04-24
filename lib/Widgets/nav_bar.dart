import 'package:flutter/material.dart';
import 'package:puppy_pal/my_icons_icons.dart';
import '../pages/calm_page.dart';
import '../pages/diary/diary_page.dart';
import '../pages/care_page.dart';
import '../pages/read_page.dart';
import '../pages/exercise/exercise_page.dart';
import '../pages/calendar/calendar_page.dart';
import '../pages/about_page.dart';
import 'colors.dart' as color;

const colorText = Color.fromARGB(255, 66, 18, 121);
const iconSize = 30;

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: color.AppColor.menuBackground,
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(height: 48),
            buildSearchField(),
            buildMenuItem(
              text: 'Care for Puppy',
              icon: MyIcons.careIcon,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(height: 15),
            buildMenuItem(
              text: 'Diary',
              icon: MyIcons.notesIcon,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 15),
            buildMenuItem(
              text: 'Calm down with Puppy',
              icon: MyIcons.breatheIcon,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(height: 15),
            buildMenuItem(
              text: 'Read to Puppy',
              icon: MyIcons.studentReadingIcon,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(height: 15),
            buildMenuItem(
              text: 'Exercise with Puppy',
              icon: MyIcons.dumbbellIcon,
              onClicked: () => selectedItem(context, 4),
            ),
            const SizedBox(height: 15),
            buildMenuItem(
              text: 'Calendar',
              icon: MyIcons.calendarIcon,
              onClicked: () => selectedItem(context, 5),
            ),
            const SizedBox(height: 24),
            Divider(color: color.AppColor.menuText),
            const SizedBox(height: 15),
            buildMenuItem(
              text: 'About',
              icon: Icons.info_outline_rounded,
              onClicked: () => selectedItem(context, 6),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    return ListTile(
      leading: Icon(icon, color: color.AppColor.menuText),
      title: Text(text, style: TextStyle(color: color.AppColor.menuText)),
      hoverColor: color.AppColor.navbarColour
          .withOpacity(0.5), //for web app, when cursor hovers over
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context)
        .pop(); //close menu drawer when navigating to another page
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const CarePage(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const DiaryPage(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const CalmPage(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ReadingPage(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ExercisePage(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const CalendarPage(),
        ));
        break;
      case 6:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AboutPage(),
          ),
        );
        break;
    }
  }

  Widget buildSearchField() {
    const color = Colors.white;
    return TextField(
      style: const TextStyle(color: colorText),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        hintText: 'Search',
        hintStyle: const TextStyle(color: color),
        prefixIcon: const Icon(Icons.search, color: colorText),
        filled: true,
        fillColor: const Color.fromARGB(125, 247, 244, 244),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: colorText.withOpacity(0.1))),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: colorText.withOpacity(0.7)),
        ),
      ),
    );
  }
}
