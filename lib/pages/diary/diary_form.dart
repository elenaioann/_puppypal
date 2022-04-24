import 'package:flutter/material.dart';
import '../../Widgets/colors.dart' as color;

class DiaryForm extends StatelessWidget {
  final bool? isEssential;
  final int? number;
  final String? title;
  final String? description;

  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const DiaryForm({
    Key? key,
    this.isEssential = false,
    this.number = 0,
    this.title = '',
    this.description = '',
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              const SizedBox(height: 8),
              buildDescription(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: TextStyle(
          color: color.AppColor.boxColor1,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Today I feel.. ',
          hintStyle: TextStyle(color: color.AppColor.boxColor1, fontSize: 30),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        style: TextStyle(color: color.AppColor.boxColor1, fontSize: 22),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Today was a good/bad day because...',
          hintStyle: TextStyle(color: color.AppColor.boxColor1, fontSize: 22),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'You forgot to write here' : null,
        onChanged: onChangedDescription,
      );
}
