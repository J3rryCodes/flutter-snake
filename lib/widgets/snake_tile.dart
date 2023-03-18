import 'package:flutter/material.dart';
import 'package:snake/controller/game_controller.dart';

class SnakeTile extends StatelessWidget {
  final double tileSize;
  final GameFlags gameFlags;
  const SnakeTile({super.key, required this.tileSize, required this.gameFlags});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: tileSize,
      width: tileSize,
      color: _getTileColor(),
    );
  }

  Color? _getTileColor() {
    switch (gameFlags) {
      case GameFlags.empty:
        return null;
      case GameFlags.head:
        return Colors.blue;
      case GameFlags.body:
        return Colors.amber[200];
      case GameFlags.apple:
        return Colors.red;
    }
  }
}
