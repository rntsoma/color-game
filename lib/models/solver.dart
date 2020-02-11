import 'package:flutter/material.dart';
import 'dart:math';

// enum BoardColors { red, green, blue, purple, orange }

class Solver {
  var _matrix;
  var _boardSize;

  Solver(int boardSize) {
    this._boardSize = boardSize;
  }

  List<Color> _colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.orange
  ];

  generateBoard() {
    _matrix = List(_boardSize);
    for (int i = 0; i < _boardSize; i++) {
      _matrix[i] = [
        for (var i = 0; i < _boardSize; i++)
          _colorList[Random().nextInt(_colorList.length)]
      ];
    }
    return _matrix;
  }

  getCurrentBoard() {
    return _matrix;
  }

  bool _shouldVisitCell(Color currColor, Color newColor, int cellRow,
      int cellCol, var visitedMatrix) {
    // cell visit check
    if (visitedMatrix[cellRow][cellCol] == true) {
      return false;
    }

    //color check
    if (currColor != newColor) {
      return false;
    }

    print("Visiting: row: $cellRow col: $cellCol");
    return true;
  }

  bool _cellInBound(int cellRow, int cellCol) {
    // boundary check
    if (cellRow >= _boardSize) {
      return false;
    } else if (cellRow < 0) {
      return false;
    } else if (cellCol >= _boardSize) {
      return false;
    } else if (cellCol < 0) {
      return false;
    }
    return true;
  }

  void treatInput(int index) {
    Color newColor = _colorList[index];
    _visitCel(_matrix[0][0], newColor, 0, 0, getEmptyBoolArray());
  }

  void _visitCel(
      Color currColor, Color newColor, int row, int col, var visitedMatrix) {
    //set itself as visited
    visitedMatrix[row][col] = true;

    // visit above
    if (_cellInBound(row - 1, col)) {
      if (_shouldVisitCell(
          currColor, _matrix[row - 1][col], row - 1, col, visitedMatrix)) {
        _visitCel(currColor, newColor, row - 1, col, visitedMatrix);
      }
    }

    // visit below
    if (_cellInBound(row + 1, col)) {
      if (_shouldVisitCell(
          currColor, _matrix[row + 1][col], row + 1, col, visitedMatrix)) {
        _visitCel(currColor, newColor, row + 1, col, visitedMatrix);
      }
    }

    // visit left
    if (_cellInBound(row, col + 1)) {
      if (_shouldVisitCell(
          currColor, _matrix[row][col + 1], row, col + 1, visitedMatrix)) {
        _visitCel(currColor, newColor, row, col + 1, visitedMatrix);
      }
    }

    // visit right
    if (_cellInBound(row, col - 1)) {
      if (_shouldVisitCell(
          currColor, _matrix[row][col - 1], row, col - 1, visitedMatrix)) {
        _visitCel(currColor, newColor, row, col - 1, visitedMatrix);
      }
    }

    // update cell color
    _matrix[row][col] = newColor;
  }

  void printMatrix() {
    print(_matrix);
  }

  List getEmptyBoolArray() {
    var arr = List(_boardSize);
    for (int i = 0; i < _boardSize; i++) {
      arr[i] = [for (var i = 0; i < _boardSize; i++) false];
    }
    return arr;
  }
}
