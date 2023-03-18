import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake/constents/game_constents.dart';
import 'package:snake/models/board_tile_model.dart';

enum GameFlags { empty, head, body, apple }

enum MovementDirections { left, right, up, down }

class GameController with ChangeNotifier {
  List<List<GameFlags>> boardTile = [];
  final List<List<int>> _snakeLocation = [];
  MovementDirections _currentMovementDirection = MovementDirections.left;
  MovementDirections _previousMovementDirection = MovementDirections.left;
  List<int> _appleLocation = [];
  bool isGameOver = false;

  intiBoard() {
    _initSnakeLocation();
    _appendSnakeToBoard();
    _findAppleLocation();
    _spwanApple();
  }

  controlSnakeMovement(MovementDirections movementDirections) {
    if (_previousMovementDirection == MovementDirections.right &&
        movementDirections == MovementDirections.left) return;
    if (_previousMovementDirection == MovementDirections.left &&
        movementDirections == MovementDirections.right) return;
    if (_previousMovementDirection == MovementDirections.up &&
        movementDirections == MovementDirections.down) return;
    if (_previousMovementDirection == MovementDirections.down &&
        movementDirections == MovementDirections.up) return;
    _previousMovementDirection = _currentMovementDirection;
    _currentMovementDirection = movementDirections;
  }

  moveSnake() {
    for (int i = _snakeLocation.length - 1; i == 1; i--) {
      _snakeLocation[i] = _snakeLocation[i - 1];
    }
    List<int> newHeadLocation = [];
    switch (_currentMovementDirection) {
      case MovementDirections.left:
        newHeadLocation = [_snakeLocation[0][0], _snakeLocation[0][1] - 1];
        if (_snakeLocation[0][1] <= 0) {
          newHeadLocation = [_snakeLocation[0][0], bodyToBoardRatio - 1];
        }
        _snakeLocation[0] = newHeadLocation;
        break;
      case MovementDirections.right:
        newHeadLocation = [_snakeLocation[0][0], _snakeLocation[0][1] + 1];
        if (_snakeLocation[0][1] + 1 >= bodyToBoardRatio) {
          newHeadLocation = [_snakeLocation[0][0], 0];
        }
        _snakeLocation[0] = newHeadLocation;
        break;
      case MovementDirections.up:
        newHeadLocation = [_snakeLocation[0][0] - 1, _snakeLocation[0][1]];
        if (_snakeLocation[0][0] - 1 < 0) {
          newHeadLocation = [bodyToBoardRatio - 1, _snakeLocation[0][1]];
        }
        _snakeLocation[0] = newHeadLocation;
        break;
      case MovementDirections.down:
        newHeadLocation = [_snakeLocation[0][0] + 1, _snakeLocation[0][1]];
        if (_snakeLocation[0][0] + 1 >= bodyToBoardRatio) {
          newHeadLocation = [0, _snakeLocation[0][1]];
        }
        _snakeLocation[0] = newHeadLocation;
        break;
    }
    _appendSnakeToBoard();
    _spwanApple();
    notifyListeners();
  }

  bool _checkHeadIsOk(List<int> newHeadLocation) {
    return _snakeLocation.contains(newHeadLocation);
  }

  void _spwanApple() {
    boardTile[_appleLocation[0]][_appleLocation[1]] = GameFlags.apple;
  }

  void _findAppleLocation() {
    int row = Random().nextInt(bodyToBoardRatio);
    int column = Random().nextInt(bodyToBoardRatio);
    _appleLocation = [row, column];
    while (_snakeLocation.contains(_appleLocation) || _appleLocation.isEmpty) {
      _findAppleLocation();
    }
  }

  void _appendSnakeToBoard() {
    _refreshBoard();
    for (int i = 0; i < _snakeLocation.length; i++) {
      if (i == 0) {
        boardTile[_snakeLocation[i][0]][_snakeLocation[i][1]] = GameFlags.head;
      } else {
        boardTile[_snakeLocation[i][0]][_snakeLocation[i][1]] = GameFlags.body;
      }
    }
  }

  void _initSnakeLocation() {
    _snakeLocation
        .add([(bodyToBoardRatio / 2).floor(), (bodyToBoardRatio / 2).floor()]);
    _snakeLocation.add(
        [(bodyToBoardRatio / 2).floor(), (bodyToBoardRatio / 2).floor() + 1]);
  }

  void _refreshBoard() {
    boardTile = [];
    for (int i = 0; i < bodyToBoardRatio; i++) {
      List<GameFlags> temp = [];
      for (int j = 0; j < bodyToBoardRatio; j++) {
        temp.add(GameFlags.empty);
      }
      boardTile.add(temp);
    }
  }
}
