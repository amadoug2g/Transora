import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transora/src/features/audio_library/audio_file.dart';
import 'package:transora/src/repository/audio_file_dao.dart';
import 'package:transora/src/utils/ui_library/audio_library/audio_cardview.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _dao = AudioFileDao();
  late Future<List<AudioFile>> _audioFiles;
  final List<String> fileExtensions = ["mp3", "wav", "aac"];

  @override
  void initState() {
    super.initState();
    _audioFiles = _dao.getAll();
  }

  Future<void> handleFilePicker() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: fileExtensions,
      type: FileType.custom,
    );

    if (result == null) return;

    final srcPath = result.files.single.path!;
    final fileName = result.files.single.name;

    final appDir = await getApplicationDocumentsDirectory();

    final nameOnly = fileName.replaceAll(RegExp(r'\.\w+$'), '');
    final ext = fileName.split('.').last;
    final unique = '$nameOnly-${DateTime.now().millisecondsSinceEpoch}.$ext';
    final destPath = '${appDir.path}/$unique';

    try {
      final bytes = result.files.single.bytes;
      if (bytes != null) {
        final file = File(destPath);
        await file.writeAsBytes(bytes);
      } else {
        await File(srcPath).copy(destPath);
      }

      final audio = AudioFile(
        title: fileName,
        path: destPath,
      );
      await _dao.insert(audio);
    } on Exception catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }

    setState(() {
      _audioFiles = _dao.getAll();
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('New File Added')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Transora"),
      ),
      body: FutureBuilder<List<AudioFile>>(
        future: _audioFiles,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final audioFiles = snapshot.data ?? [];

          if (audioFiles.isEmpty) {
            return const Center(child: Text("No audio files added yet."));
          }

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _audioFiles = _dao.getAll();
              });
              await _audioFiles;
            },
            child: ListView.builder(
              itemCount: audioFiles.length,
              itemBuilder: (context, index) {
                final audio = audioFiles[index];
                return AudioCardView(
                  audio: audio,
                  destination: "details",
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await handleFilePicker(),
        child: const Icon(Icons.file_download_outlined),
      ),
    );
  }
}
