class AudioFile {
  AudioFile({
    required this.path,
    required this.title,
    this.transcript = "",
    this.id,
    DateTime? importedAt,
  }) : importedAt = importedAt ?? DateTime.now();

  factory AudioFile.fromMap(Map<String, dynamic> m) {
    return AudioFile(
      id: m['id'] as int?,
      title: m['title'] as String,
      path: m['path'] as String,
      transcript: m['transcript'] as String? ?? "",
      importedAt: DateTime.parse(m['importedAt'] as String),
    );
  }

  final int? id;
  String title;
  final String path;
  String transcript;
  final DateTime importedAt;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'path': path,
      'transcript': transcript,
      'importedAt': importedAt.toIso8601String(),
    };
  }

  String formattedDate() {
    final dt = importedAt.toLocal();
    final d = dt.day.toString().padLeft(2, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final y = dt.year;
    return "$d/$m/$y";
  }
}
