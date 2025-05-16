import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:transora/src/features/audio_library/audio_file.dart';
import 'package:transora/src/utils/ui_library/audio_playback/playback_controls.dart';
import 'package:transora/src/utils/ui_library/audio_playback/playback_slider.dart';
import 'package:transora/src/utils/ui_library/audio_playback/transcription_tabs.dart';

class AudioPlaybackScreen extends StatefulWidget {
  const AudioPlaybackScreen({
    required this.audioFile,
    super.key,
  });

  final AudioFile audioFile;

  @override
  State<AudioPlaybackScreen> createState() => _AudioPlaybackScreenState();
}

class _AudioPlaybackScreenState extends State<AudioPlaybackScreen> {
  late final AudioPlayer _player;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    debugPrint('Audio path: ${widget.audioFile.path}');

    _initializePlayer();

    _player.playerStateStream.listen((state) {
      setState(() => _playing = state.playing);
    });

    _player.positionStream.listen((pos) {
      setState(() => _position = pos);
    });
  }

  Future<void> _initializePlayer() async {
    try {
      final duration = await _player.setFilePath(widget.audioFile.path);
      setState(() => _duration = duration ?? Duration.zero);
    } on Exception catch (e) {
      debugPrint('Error loading audio: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load audio file')),
      );
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.audioFile.title),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Transcript'),
              Tab(text: 'Summary'),
            ],
          ),
        ),
        body: Column(
          children: [
            PlaybackTranscriptionTabs(
              audioFile: widget.audioFile,
            ),
            PlaybackSlider(
              duration: _duration,
              position: _position,
              player: _player,
            ),
            PlaybackControls(
              position: _position,
              player: _player,
              playing: _playing,
            ),
          ],
        ),
      ),
    );
  }
}
