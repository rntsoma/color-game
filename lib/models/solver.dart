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
    _matrix = [[BoardColors.green, BoardColors.green, BoardColors.green],
               [BoardColors.red, BoardColors.red, BoardColors.green],
               [BoardColors.blue, BoardColors.green, BoardColors.green]];
  //   _matrix = List(_boardSize);
  //   for (int i = 0; i < _boardSize; i++) {
  //     _matrix[i] = [
  //       for (var i = 0; i < _boardSize; i++) BoardColors.values[Random().nextInt(_boardSize)]
  //     ];
  //   }
  }

  void printMatrix() {
    print(_matrix);
    print("change color");
    modifyColor(BoardColors.blue, _matrix[0][0], 0, 0);
    print(_matrix);
  }

//bug -> not backtracking correctly
  void modifyColor(BoardColors newColor, BoardColors currColor, int row, int col) {
    if (row == col && row == _boardSize) {
      _matrix[row][col] = newColor;
      return;
    }

    if (row + 1 < _boardSize && currColor == _matrix[row+1][col]) {
      modifyColor(newColor, currColor, row + 1, col);
    }

    if (col + 1 < _boardSize && currColor == _matrix[row][col+1]) {
      modifyColor(newColor, currColor, row, col + 1);
    }

    _matrix[row][col] = newColor;
  }

}
