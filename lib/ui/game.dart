import 'package:flutter/material.dart';

import 'package:flutter_scene/scene.dart';

class GameWidget extends StatefulWidget {
  const GameWidget({super.key});

  @override
  State<GameWidget> createState() => _GameWidgetState();
}

enum GameMode { startMenu, playing, leaderboardEntry }

class _GameWidgetState extends State<GameWidget> {
  Scene scene = Scene();
  GameMode gameMode = GameMode.startMenu;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
