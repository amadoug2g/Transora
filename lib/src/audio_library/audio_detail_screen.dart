import 'package:flutter/material.dart';

class AudioDetailScreen extends StatelessWidget {
  const AudioDetailScreen({
    required this.title,
    super.key,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Detail Screen: $title"),
      ),
    );
  }
}
