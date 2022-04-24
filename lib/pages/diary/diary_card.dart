import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:puppy_pal/pages/diary/diary.dart';

final _lightColors = [
  const Color.fromARGB(255, 183, 250, 244),
  const Color.fromARGB(255, 219, 255, 178),
  const Color.fromARGB(255, 246, 180, 245),
  const Color.fromARGB(255, 238, 246, 179),
  const Color.fromARGB(255, 244, 177, 200),
  const Color.fromARGB(255, 183, 167, 255)
];

class DiaryCard extends StatelessWidget {
  const DiaryCard({
    Key? key,
    required this.diary,
    required this.index,
  }) : super(key: key);

  final Diary diary;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().format(diary.creationTime);

    return Card(
      color: color,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: const TextStyle(color: Color.fromARGB(255, 51, 36, 120)),
            ),
            const SizedBox(height: 4),
            Text(
              diary.title,
              style: const TextStyle(
                color: Color.fromARGB(255, 41, 21, 96),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              diary.description,
              style: const TextStyle(
                color: Color.fromARGB(255, 41, 21, 96),
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
