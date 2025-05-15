import 'package:flutter/material.dart';
import 'package:transora/src/features/audio_library/audio_file.dart';

class AudioDetailScreen extends StatelessWidget {
  const AudioDetailScreen({required this.audioFile, super.key});

  final AudioFile audioFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Audio"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(child: Text("Details: ${audioFile.title}")),
    );
  }
}
