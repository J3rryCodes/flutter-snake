import 'package:flutter/material.dart';
import 'package:snake/constents/game_constents.dart';
import 'package:snake/models/board_tile_model.dart';

enum GameFlags { Empty, Head, Body, Apple }

class GameController with ChangeNotifier {
  List<List<GameFlags>> boardTile = [];

  intiBoard() {
    for (int i = 0; i < bodyToBoardRatio; i++) {
      List<GameFlags> temp = [];
      for (int j = 0; j < bodyToBoardRatio; j++) {
        //checking middle row
        if (i == bodyToBoardRatio / 2) {
          // if middle column then , its Head
          if (j == bodyToBoardRatio / 2) {
            temp.add(GameFlags.Head);
          } else if (j == (bodyToBoardRatio / 2 + 1)) {
            temp.add(GameFlags.Body);
          } else {
            temp.add(GameFlags.Empty);
          }
        } else {
          temp.add(GameFlags.Empty);
        }
      }
      boardTile.add(temp);
    }
  }
}
