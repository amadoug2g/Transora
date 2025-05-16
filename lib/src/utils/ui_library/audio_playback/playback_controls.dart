import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlaybackControls extends StatelessWidget {
  const PlaybackControls({
    required Duration position,
    required AudioPlayer player,
    required bool playing,
    super.key,
  })  : _position = position,
        _player = player,
        _playing = playing;

  final Duration _position;
  final AudioPlayer _player;
  final bool _playing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.replay_5),
            onPressed: () => _player.seek(
              _position - const Duration(seconds: 5),
            ),
          ),
          const SizedBox(width: 32),
          IconButton(
            icon: Icon(
              _playing ? Icons.pause_circle_filled : Icons.play_circle_fill,
            ),
            iconSize: 64,
            onPressed: () => _playing ? _player.pause() : _player.play(),
          ),
          const SizedBox(width: 32),
          IconButton(
            icon: const Icon(Icons.forward_5),
            onPressed: () => _player.seek(
              _position + const Duration(seconds: 5),
            ),
          ),
        ],
      ),
    );
  }
}
