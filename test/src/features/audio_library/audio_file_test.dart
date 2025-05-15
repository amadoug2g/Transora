import 'package:flutter_test/flutter_test.dart';
import 'package:transora/src/features/audio_library/audio_file.dart';

void main() {
  final Map<String, dynamic> audioMap = {
    'id': 1964,
    'title': "fly_me_to_the_moon",
    'path': "path/to/the/file.wav",
    'transcript': "",
    'importedAt': DateTime.utc(1954, 4, 1).toIso8601String(),
  };

  test("AudioFile mapping check", () {
    final audioFile = AudioFile.fromMap(audioMap);

    final map = audioFile.toMap();

    expect(AudioFile.fromMap(map).id, audioFile.id);
    expect(AudioFile.fromMap(map).title, audioFile.title);
    expect(AudioFile.fromMap(map).path, audioFile.path);
    expect(AudioFile.fromMap(map).transcript, audioFile.transcript);
    expect(AudioFile.fromMap(map).importedAt, audioFile.importedAt);
  });

  test("AudioFile date formatting", () {
    final audioFile = AudioFile.fromMap(audioMap);

    final date = audioFile.formattedDate();

    expect(date, "01/04/1954");
  });
}
