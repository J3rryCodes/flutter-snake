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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double size =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.width;

    double snakeTileSize = size / bodyToBoardRatio;
    return Center(
      child: Container(
        height: size,
        width: size,
        color: Colors.pinkAccent[100],
        alignment: Alignment.center,
        child: Column(
          children: context
              .watch<GameController>()
              .boardTile
              .map((e) => Row(
                    children: e
                        .map((e) =>
                            SnakeTile(tileSize: snakeTileSize, gameFlags: e))
                        .toList(),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
