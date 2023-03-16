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
      case GameFlags.Empty:
        return null;
      case GameFlags.Head:
        return Colors.blue;
      case GameFlags.Body:
        return Colors.amber[200];
      case GameFlags.Apple:
        return Colors.red;
    }
  }
}
