import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transora/src/features/audio_library/audio_file.dart';

class AudioCardView extends StatelessWidget {
  const AudioCardView({
    required this.audio,
    required this.destination,
    super.key,
  });

  final AudioFile audio;
  final String destination;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(audio.title),
        subtitle: Row(
          children: [
            Text(audio.formattedDate()),
            Text(format.formattedDate()),
          ],
        ),
        leading: const Icon(Icons.music_note_rounded),
        onTap: () => context.goNamed(
          destination,
          extra: audio,
        ),
      ),
    );
  }
}
