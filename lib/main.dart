import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transora/src/features/audio_library/audio_file.dart';
import 'package:transora/src/features/audio_library/library_screen.dart';
import 'package:transora/src/features/audio_player/audio_detail_screen.dart';

void main() => runApp(const Transora());

final _router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const LibraryScreen(),
      routes: [
        GoRoute(
          path: "details",
          builder: (context, state) {
            final audio = state.extra! as AudioFile;
            return AudioDetailScreen(
              audioFile: audio,
            );
          },
        ),
      ],
    ),
  ],
);

class Transora extends StatelessWidget {
  const Transora({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Transora',
      debugShowCheckedModeBanner: false,
    );
  }
}
