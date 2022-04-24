//displays the page when selecting a note from the first page
//gives the chance to edit and/or delete the note

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

//function called when object is inserted in the stack tree
  @override
  void initState() {
    super.initState();
    refreshDiary();
  }

//displays the previously written note
  Future refreshDiary() async {
    setState(() => isLoading = true);

    diary = await DiaryDatabase.item.readDiary(widget.diaryId);
    setState(() => isLoading = false);
  }

//determines the look of the page
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: color.AppColor.navbarColour,
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? const Center(
                child:
                    CircularProgressIndicator()) //if true, it shows the circular progress indicator until the function is false
            : Padding(
                //,else shows the note
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
                      DateFormat.yMMMd().format(diary
                          .creationTime), //US formating date e.g. June 30,1997
                      style: TextStyle(color: color.AppColor.boxColor1),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      diary
                          .description, //displays the user input, the main text
                      style: TextStyle(
                        color: color.AppColor.boxColor1,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
      );

  //Delete icon and functionality
  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await DiaryDatabase.item.delete(widget.diaryId);

          Navigator.of(context).pop();
        },
      );

  //Edit button and functionality
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
