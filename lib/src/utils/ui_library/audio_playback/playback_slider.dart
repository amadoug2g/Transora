import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlaybackSlider extends StatefulWidget {
  const PlaybackSlider({
    required this.duration,
    required this.position,
    required this.player,
    super.key,
  });

  final Duration duration;
  final Duration position;
  final AudioPlayer player;

  @override
  State<PlaybackSlider> createState() => _PlaybackSliderState();
}

class _PlaybackSliderState extends State<PlaybackSlider> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Slider(
            min: 0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: widget.position.inMilliseconds
                .clamp(0, widget.duration.inMilliseconds)
                .toDouble(),
            onChanged: (v) =>
                widget.player.seek(Duration(milliseconds: v.round())),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_format(widget.position)),
              Text(_format(widget.duration)),
            ],
          ),
        ],
      ),
    );
  }

  String _format(Duration d) {
    final two = (int n) => n.toString().padLeft(2, '0');
    final m = two(d.inMinutes.remainder(60));
    final s = two(d.inSeconds.remainder(60));
    return '$m:$s';
  }
}
