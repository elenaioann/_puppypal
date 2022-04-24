//new model for diary
//turning the data into json format

const String diaryNotes = 'diary'; //name of table

class DiaryFields {
  static final List<String> values = [
    id,
    isEssential,
    number,
    title,
    description,
    time,
  ];

  //will be used as column names for the db
  static const String id = '_id';
  static const String isEssential = 'isEssential';
  static const String number = 'number';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
}

class Diary {
  //data we want stored in the database
  final int? id;
  final bool isEssential;
  final int number;
  final String title;
  final String description;
  final DateTime creationTime;

  const Diary({
    this.id,
    required this.isEssential,
    required this.number,
    required this.title,
    required this.description,
    required this.creationTime,
  });

//copy method to create a copy of the current object
//this shows the values we want to modify
  Diary copy({
    int? id,
    bool? isEssential,
    int? number,
    String? title,
    String? description,
    DateTime? creationTime,
  }) =>
      Diary(
        id: id ?? this.id,
        isEssential: isEssential ?? this.isEssential,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        creationTime: creationTime ?? this.creationTime,
      );

  static Diary fromJson(Map<String, Object?> json) => Diary(
        id: json[DiaryFields.id] as int?,
        isEssential: json[DiaryFields.isEssential] == 1,
        number: json[DiaryFields.number] as int,
        title: json[DiaryFields.title] as String,
        description: json[DiaryFields.description] as String,
        creationTime: DateTime.parse(json[DiaryFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        //convert data to json
        //map of key/value pairs
        DiaryFields.id: id,
        DiaryFields.title: title,
        //special cases like boolean and DayTime need to be converted
        DiaryFields.isEssential: isEssential ? 1 : 0, //if true=1, else false=0
        DiaryFields.number: number,
        DiaryFields.description: description,
        DiaryFields.time: creationTime.toIso8601String(),
      };
}
