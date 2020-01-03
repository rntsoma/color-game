import 'dart:math';

enum BoardColors { red, green, blue, purple, orange }

class Solver {
  var _matrix;
  var _boardSize;

  Solver(int boardSize) {
    this._boardSize = boardSize;
  }

  void generateBoard() {
    // _matrix = [[1,1,1],[1,1,1],[1,1,1]];
    _matrix = [
      [BoardColors.green, BoardColors.green, BoardColors.green],
      [BoardColors.red, BoardColors.red, BoardColors.green],
      [BoardColors.blue, BoardColors.green, BoardColors.green]
    ];
    //   _matrix = List(_boardSize);
    //   for (int i = 0; i < _boardSize; i++) {
    //     _matrix[i] = [
    //       for (var i = 0; i < _boardSize; i++) BoardColors.values[Random().nextInt(_boardSize)]
    //     ];
    //   }
  }

  bool shouldVisitCell(BoardColors currColor, BoardColors newColor, int cellRow,
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

  bool cellInBound(int cellRow, int cellCol) {
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

  void visitCell(BoardColors currColor, BoardColors newColor, int row, int col,
      var visitedMatrix) {
    //set itself as visited
    visitedMatrix[row][col] = true;

    // visit above
    if (cellInBound(row - 1, col)) {
      if (shouldVisitCell(
          currColor, _matrix[row - 1][col], row - 1, col, visitedMatrix)) {
        visitCell(currColor, newColor, row - 1, col, visitedMatrix);
      }
    }

    // visit below
    if (cellInBound(row + 1, col)) {
      if (shouldVisitCell(currColor, _matrix[row + 1][col], row + 1, col, visitedMatrix)) {
        visitCell(currColor, newColor, row + 1, col, visitedMatrix);
      }
    }

    // visit left
    if (cellInBound(row, col + 1)) {
      if (shouldVisitCell(currColor, _matrix[row][col + 1], row, col + 1, visitedMatrix)) {
        visitCell(currColor, newColor, row, col + 1, visitedMatrix);
      }
    }

    // visit right
    if (cellInBound(row, col - 1)) {
      if (shouldVisitCell(currColor, _matrix[row][col - 1], row, col - 1, visitedMatrix)) {
        visitCell(currColor, newColor, row, col - 1, visitedMatrix);
      }
    }

    // update cell color
    _matrix[row][col] = newColor;
  }

  // debug methods
  void debugTrivialBoard() {
    var visitedMatrix = getEmptyBoolArray();

    visitCell(_matrix[0][0], BoardColors.blue, 0, 0, visitedMatrix);
    printMatrix();
    visitedMatrix = getEmptyBoolArray();

    visitCell(_matrix[0][0], BoardColors.red, 0, 0, visitedMatrix);
    printMatrix();
    visitedMatrix = getEmptyBoolArray();

    visitCell(_matrix[0][0], BoardColors.purple, 0, 0, visitedMatrix);
    printMatrix();
  }

  void printMatrix() {
    print(_matrix);
  }

  List getEmptyBoolArray(){
    var arr= List(_boardSize);
    for (int i = 0; i < _boardSize; i++) {
      arr[i] = [for (var i = 0; i < _boardSize; i++) false];
    }
    return arr;
  }
}
