import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:snake/constents/game_constents.dart';
import 'package:snake/controller/game_controller.dart';
import 'package:snake/widgets/snake_tile.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late FocusNode _focusNode;
  @override
  void initState() {
    context.read<GameController>().intiBoard();

    super.initState();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.width;

    double snakeTileSize = size / bodyToBoardRatio;

    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: (event) {
        if (event is RawKeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            context
                .read<GameController>()
                .controlSnakeMovement(MovementDirections.up);
          } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            context
                .read<GameController>()
                .controlSnakeMovement(MovementDirections.down);
          } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            context
                .read<GameController>()
                .controlSnakeMovement(MovementDirections.left);
          } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            context
                .read<GameController>()
                .controlSnakeMovement(MovementDirections.right);
          }
        }
      },
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0) {
            context
                .read<GameController>()
                .controlSnakeMovement(MovementDirections.right);
          } else if (details.delta.dx < 0) {
            context
                .read<GameController>()
                .controlSnakeMovement(MovementDirections.left);
          }
        },
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0) {
            context
                .read<GameController>()
                .controlSnakeMovement(MovementDirections.down);
          } else if (details.delta.dy < 0) {
            context
                .read<GameController>()
                .controlSnakeMovement(MovementDirections.up);
          }
        },
        onTap: () => context.read<GameController>().moveSnake(),
        child: Center(
          child: Container(
            height: size,
            width: size,
            color: Colors.pinkAccent[100],
            alignment: Alignment.center,
            child: Stack(
              children: [
                Column(
                  children: context
                      .watch<GameController>()
                      .boardTile
                      .map((e) => Row(
                            children: e
                                .map((e) => SnakeTile(
                                    tileSize: snakeTileSize, gameFlags: e))
                                .toList(),
                          ))
                      .toList(),
                ),
                context.watch<GameController>().isGameOver
                    ? Center(
                        child: Text(
                          "Game Over",
                          style: _getTextStyle(size),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _getTextStyle(double size) {
    return TextStyle(
        color: Colors.red, fontWeight: FontWeight.bold, fontSize: 0.05 * size);
  }
}
