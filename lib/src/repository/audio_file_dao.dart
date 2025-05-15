import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:transora/src/features/audio_library/audio_file.dart';
import 'package:transora/src/repository/db_helper.dart';

class AudioFileDao {
  final helper = DatabaseHelper();

  Future<int> insert(AudioFile audioFile) async {
    final db = await helper.db;
    return db.insert(
      'audio_files',
      audioFile.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<AudioFile>> getAll() async {
    final db = await helper.db;
    final rows = await db.query('audio_files', orderBy: 'title ASC');
    return rows.map((r) => AudioFile.fromMap(r)).toList();
  }

  Future<int> update(AudioFile audioFile) async {
    final db = await helper.db;
    return db.update(
      'audio_files',
      audioFile.toMap(),
      where: 'id = ?',
      whereArgs: [audioFile.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await helper.db;
    return db.delete('audio_files', where: 'id = ?', whereArgs: [id]);
  }
}
