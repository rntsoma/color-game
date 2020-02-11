import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_squares/models/solver.dart';
import 'package:flutter_squares/ui/cellcontroller.dart';
import 'package:flutter_squares/ui/boardcell.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Solver solv = Solver(10);
  List<BoardCell> board = [];

  double _getSmallestDimension(var height, var width) {
    double ret;

    ret = height > width ? width : height;
    return ret;
  }

  /// XXX Refactor this on both sides
  List<BoardCell> _getBoardUI(double cellSize, int lines){
    if (board.isEmpty){
      var generatedBoard;

      generatedBoard = solv.generateBoard();
      for (int i=0; i<lines; i++) {
        for (int j=0; j<lines; j++) {
          board.add(BoardCell(generatedBoard[i][j], cellSize));
        }
      }
    }
    return board;
  }

  Color _getColor(int offset) {
    List<Color> colors = [Colors.red, Colors.green,
      Colors.blue, Colors.purple, Colors.orange];
    return colors[offset];
  }

  List<CellController> _createControllers(int count, Function cb) {
    List<CellController> controllers = List();

    for (int i=0; i<count; i++){
      controllers.add(CellController(i, _getColor(i), cb));
    }
    return controllers;
  }

  Future<void> controllerCB(var index, var lines, var cellSize) async{
    print("index pressed: $index");
    setState(() {
      solv.treatInput(index);
      print("board not empty");
      var updatedBoard;
      List<BoardCell> retBoard = [];

      updatedBoard = solv.getCurrentBoard();
      for (int i=0; i<lines; i++) {
        for (int j=0; j<lines; j++) {
          retBoard.add(BoardCell(updatedBoard[i][j], cellSize));
        }
      }
      board = retBoard;
    });
  }

  @override
  Widget build(BuildContext context) {
    const lines = 10;

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("ColorGame"),
              centerTitle: true,
              backgroundColor: Colors.deepPurple,
            ),
            body: Padding(
                padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    var cellSize = _getSmallestDimension(
                            constraints.maxHeight, constraints.maxWidth) /
                        lines;
                    return _drawBoard(lines, cellSize,
                      (index) async {
                        controllerCB(index, lines, cellSize);}
                    );
                  },
                ))));
  }

  Widget _drawBoard(int lines, double cellSize, Function cb) {
    board = _getBoardUI(cellSize, lines);
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GridView.count(
        crossAxisCount: lines,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: board
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _createControllers(5, cb)
    )]);
  }
}
