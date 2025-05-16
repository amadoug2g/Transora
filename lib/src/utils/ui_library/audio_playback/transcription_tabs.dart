import 'package:flutter/material.dart';
import 'package:transora/src/features/audio_library/audio_file.dart';

class PlaybackTranscriptionTabs extends StatelessWidget {
  const PlaybackTranscriptionTabs({
    required this.audioFile,
    super.key,
  });

  final AudioFile audioFile;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: audioFile.transcript.isEmpty
                ? const Center(child: Text('No transcript available'))
                : SingleChildScrollView(
                    child: Text(audioFile.transcript),
                  ),
          ),
          const Center(child: Text('No summary available')),
        ],
      ),
    );
  }
}
