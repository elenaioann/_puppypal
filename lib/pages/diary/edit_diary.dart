import 'package:flutter/material.dart';
import 'package:puppy_pal/pages/diary/diary.dart';
import 'package:puppy_pal/pages/diary/diary_form.dart';
import 'package:puppy_pal/pages/diary/diary_database.dart';
import '../../Widgets/colors.dart' as color;

class EditDiary extends StatefulWidget {
  final Diary? diary;

  const EditDiary({
    Key? key,
    this.diary,
  }) : super(key: key);

  @override
  _EditDiaryState createState() => _EditDiaryState();
}

class _EditDiaryState extends State<EditDiary> {
  final form = GlobalKey<FormState>();
  late bool isEssential;
  late int number;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    isEssential = widget.diary?.isEssential ?? false;
    number = widget.diary?.number ?? 0;
    title = widget.diary?.title ?? '';
    description = widget.diary?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
          backgroundColor: color.AppColor.navbarColour,
        ),
        body: Form(
          key: form,
          child: DiaryForm(
            isEssential: isEssential,
            number: number,
            title: title,
            description: description,
            onChangedNumber: (number) => setState(() => this.number = number),
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
          ),
        ),
      );

  Widget buildButton() {
    //final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: color.AppColor.boxColor1,
            shadowColor: color.AppColor.boxColor1),
        onPressed: addUpdateDiary,
        child: const Text('Save'),
      ),
    );
  }

  void addUpdateDiary() async {
    final isValid = form.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.diary != null;

      if (isUpdating) {
        await updateDiary();
      } else {
        await addDiary();
      }
      Navigator.of(context).pop();
    }
  }

  Future updateDiary() async {
    final diary = widget.diary!.copy(
      isEssential: isEssential,
      number: number,
      title: title,
      description: description,
    );

    await DiaryDatabase.item.update(diary);
  }

  Future addDiary() async {
    final diary = Diary(
      isEssential: isEssential,
      number: number,
      title: title,
      description: description,
      creationTime: DateTime.now(),
    );
    await DiaryDatabase.item.create(diary);
  }
}
