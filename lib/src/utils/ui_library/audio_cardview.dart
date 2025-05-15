import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transora/src/features/audio_library/audio_file.dart';

class AudioCardView extends StatelessWidget {
  const AudioCardView({
    required this.audio,
    super.key,
  });

  final AudioFile audio;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(audio.title),
      subtitle: Text(audio.formattedDate()),
      onTap: () => context.goNamed("details", extra: audio),
    );
  }
}
