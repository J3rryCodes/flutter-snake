import 'dart:async';

import 'package:flutter/material.dart';
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
  @override
  void initState() {
    context.read<GameController>().intiBoard();
    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      context.read<GameController>().moveSnake();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double size =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.width;

    double snakeTileSize = size / bodyToBoardRatio;

    return GestureDetector(
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
          child: Builder(builder: (context) {
            return Column(
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
            );
          }),
        ),
      ),
    );
  }
}
