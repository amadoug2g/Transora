import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:transora/src/utils/extension.dart';

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
  bool _isSeeking = false;
  double _sliderValue = 0;

  @override
  void didUpdateWidget(covariant PlaybackSlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!_isSeeking) {
      _sliderValue = widget.position.inMilliseconds
          .clamp(0, widget.duration.inMilliseconds)
          .toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Slider(
            min: 0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: _sliderValue,
            onChanged: (v) {
              setState(() {
                _isSeeking = true;
                _sliderValue = v;
              });
            },
            onChangeEnd: (v) {
              widget.player.seek(Duration(milliseconds: v.round()));
              setState(() => _isSeeking = false);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(format(Duration(milliseconds: _sliderValue.round()))),
              Text(format(widget.duration)),
            ],
          ),
        ],
      ),
    );
  }
}
