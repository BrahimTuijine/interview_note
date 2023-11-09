const String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, title, description, time, userId
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
  static const String userId = 'userId';
}

class Note {
  final int? id;
  final int userId;
  final String title;
  final String description;
  final DateTime createdTime;

  Note({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Note copy({
    int? userId,
    int? id,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Note(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        userId: json[NoteFields.userId] as int,
        id: json[NoteFields.id] as int?,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.userId: userId,
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.time: createdTime.toIso8601String(),
      };
}
