import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:puppy_pal/pages/diary/diary.dart';
import 'package:puppy_pal/pages/diary/diary_database.dart';
import 'package:puppy_pal/pages/diary/edit_diary.dart';
import '../../Widgets/colors.dart' as color;

class DiaryDetailPage extends StatefulWidget {
  final int diaryId;

  const DiaryDetailPage({
    Key? key,
    required this.diaryId,
  }) : super(key: key);

  @override
  State<DiaryDetailPage> createState() => _DiaryDetailPageState();
}

class _DiaryDetailPageState extends State<DiaryDetailPage> {
  late Diary diary;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshDiary();
  }

  Future refreshDiary() async {
    setState(() => isLoading = true);

    diary = await DiaryDatabase.item.readDiary(widget.diaryId);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: color.AppColor.navbarColour,
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    Text(
                      diary.title,
                      style: TextStyle(
                        color: color.AppColor.boxColor1,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      DateFormat.yMMMd().format(diary.creationTime),
                      style: TextStyle(color: color.AppColor.boxColor1),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      diary.description,
                      style: TextStyle(
                        color: color.AppColor.boxColor1,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
      );

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await DiaryDatabase.item.delete(widget.diaryId);

          Navigator.of(context).pop();
        },
      );

  Widget editButton() => IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () async {
          if (isLoading) return;

          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditDiary(diary: diary),
            ),
          );
          refreshDiary();
        },
      );
}
