import 'dart:math';

class Solver {
  var _matrix;
  var _boardSize;

  Solver(int boardSize) {
    this._boardSize = boardSize;
  }

  void generateBoard() {
    _matrix = List(_boardSize);
    for (int i = 0; i < _boardSize; i++) {
      _matrix[i] = [for (var i = 0; i < _boardSize; i++) Random().nextInt(_boardSize)];
    }
  }

  void printMatrix() {
    print(_matrix);
  }
}
