import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transora/src/audio_library/audio_detail_screen.dart';
import 'package:transora/src/audio_library/library_screen.dart';

void main() => runApp(const Transora());

final _router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => LibraryScreen(),
      routes: [
        GoRoute(
          path: "details/:title",
          name: "details",
          builder: (context, state) {
            return AudioDetailScreen(
              title: state.pathParameters['title'],
            );
          },
        )
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
