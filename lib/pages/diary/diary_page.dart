import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:puppy_pal/pages/diary/diary.dart';
import 'package:puppy_pal/pages/diary/edit_diary.dart';
import 'package:puppy_pal/pages/diary/diary_database.dart';
import 'package:puppy_pal/pages/diary/diary_detail.dart';
import 'package:puppy_pal/pages/diary/diary_card.dart';
import '../../../Widgets/nav_bar.dart';
import '../../Widgets/colors.dart' as color;

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  late List<Diary> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshDiary();
  }

  @override
  void dispose() {
    DiaryDatabase.item.close();
    super.dispose();
  }

  Future refreshDiary() async {
    setState(() => isLoading = true);

    notes = await DiaryDatabase.item.allEntriesDiary();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text('My Diary'),
          centerTitle: true,
          backgroundColor: color.AppColor.navbarColour,
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : notes.isEmpty
                  ? Text(
                      'Press + to add notes',
                      style: TextStyle(
                          color: color.AppColor.plainText, fontSize: 23),
                    )
                  : buildDiary(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: color.AppColor.boxColor2,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const EditDiary()),
            );

            refreshDiary();
          },
        ),
      );

  Widget buildDiary() => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final diary = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DiaryDetailPage(diaryId: diary.id!),
                ),
              );
              refreshDiary();
            },
            child: DiaryCard(diary: diary, index: index),
          );
        },
      );
}
