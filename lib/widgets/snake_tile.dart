import 'package:flutter/material.dart';
import 'package:snake/controller/game_controller.dart';

class SnakeTile extends StatelessWidget {
  final double tileSize;
  final GameFlags gameFlags;
  const SnakeTile({super.key, required this.tileSize, required this.gameFlags});

  @override
  Widget build(BuildContext context) {
    switch (gameFlags) {
      case GameFlags.empty:
        return _getBoard();
      case GameFlags.head:
        return _getHead();
      case GameFlags.body:
        return _getBody();
      case GameFlags.apple:
        return _getApple();
    }
  }

  Container _getBoard() => Container(
        height: tileSize,
        width: tileSize,
        decoration: BoxDecoration(border: Border.all(color: Colors.white10)),
      );

  Container _getHead() => Container(
        height: tileSize,
        width: tileSize,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: Colors.blue),
      );

  Container _getBody() => Container(
        height: tileSize,
        width: tileSize,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: Colors.amber[100]),
      );

  Container _getApple() => Container(
        height: tileSize,
        width: tileSize,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: Colors.red),
      );
}
